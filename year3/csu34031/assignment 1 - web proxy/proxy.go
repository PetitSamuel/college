package main

import (
	"bufio"
	"fmt"
	"io"
	"net"
	"net/http"
	"os"
	"time"
)

const BLOCK_CMD = "block "
const UNBLOCK_CMD = "unblock "

var blocked []string
var cache map[string]*http.Response = make(map[string]*http.Response)

// helper function for testing which prints a slice
func printSlice(s []string) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}

// Copies from src into dst & closes read for src & write for dst.
func transfer(dst, src *net.TCPConn) {
	_, status := io.Copy(dst, src)
	if status != nil {
		fmt.Printf("[ERROR] Copying to client failed - %s", status)
	}
	src.CloseRead()
	dst.CloseWrite()
}

// Https communication contains
func httpsHandler(w http.ResponseWriter, req *http.Request) {
	dest, err := net.Dial("tcp", req.Host)
	if err != nil {
		fmt.Printf(err.Error())
	}

	hijacker, ok := w.(http.Hijacker)
	if !ok {
		http.Error(w, "[Error] hijacking http failed", http.StatusInternalServerError)
		return
	}

	client, _, err := hijacker.Hijack()
	if err != nil {
		http.Error(w, err.Error(), http.StatusServiceUnavailable)
	}

	fmt.Printf("[HANDLING CONNECT REQUEST] Host : %s\n", req.Host)
	client.Write([]byte("HTTP/1.0 200 OK\r\n\r\n"))

	// Send data
	destTcp, destOk := dest.(*net.TCPConn)
	clientTcp, clientOK := client.(*net.TCPConn)
	if destOk && clientOK {
		go transfer(destTcp, clientTcp)
		go transfer(clientTcp, destTcp)
	}

}

// Handles http requests
func onRequest(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	fmt.Printf("[RECEIVED A REQUEST] %s -- %s\n", r.Method, r.URL)
	if isDomainBlocked(r.Host) {
		fmt.Printf("[TRIED TO ACCESS BLACKLISTED DOMAIN] Request blocked - %s\n", r.Host)
		w.Write([]byte("HTTP/1.0 403 FORBIDDEN\r\n\r\n"))
		r.Body.Close()
		return
	}

	// Request URI can't be set in client requests.
	r.RequestURI = ""
	var url string = r.URL.String()

	//switch to https handler on CONNECT request
	if r.Method == http.MethodConnect {
		httpsHandler(w, r)
		return
	}

	cachedRes, ok := cache[url]
	if ok {
		fmt.Printf("[FOUND RESPONSE FROM CACHE]\n")
		cachedRes.Write(w)
		r.Body.Close()
		cachedRes.Body.Close()
		fmt.Printf("[EXECUTION TIME] %s \n\n", time.Since(start))
		return
	}

	// Handle http communication
	client := &http.Client{}
	res, err := client.Do(r)
	if err != nil {
		fmt.Printf("[ERROR] Could not forward request")
		// log.Fatal(err)
		return
	}
	fmt.Printf("[RECEIVED RESPONSE TO REQUEST] Status - %s\n", res.Status)
	// Send response back to client
	res.Write(w)
	r.Body.Close()
	res.Body.Close()
	cache[url] = res
	fmt.Printf("EXECUTION TIME - %s\n\n", time.Since(start))
}

// remove specified string from slice containing blocked domains.
func removeBlockedDomainFromString(domain string) bool {
	for i, item := range blocked {
		if domain == item {
			blocked = append(blocked[:i], blocked[i+1:]...)
			fmt.Printf("[SUCCESS] Unblocked domain %s\n", domain)
			return true
		}
	}
	return false
}

// Returns true if the specified domain is blocked.
func isDomainBlocked(domain string) bool {
	for _, item := range blocked {
		if domain == item {
			return true
		}
	}
	return false
}

// Continuously obtain user input and execute block / unblock domain actions.
func userInputHandler() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		input := scanner.Text()
		len := len(input)
		if len > 6 && input[0:6] == BLOCK_CMD {
			var domain string = input[6:]
			blocked = append(blocked, domain)
			fmt.Printf("[SUCCESS] Blocked domain %s\n", domain)
		} else if len > 8 && input[0:8] == UNBLOCK_CMD {
			var found = removeBlockedDomainFromString(input[8:])
			if !found {
				fmt.Printf("[ERROR] Tried to unblock domain that was not blocked: %s\n", input[8:])
			}
		} else {
			fmt.Printf("[ERROR] Command not supported : %s\n", input)
		}
		printSlice(blocked)
	}
}

func main() {
	fmt.Printf("[STARTING PROXY]\n")
	httpClient := http.HandlerFunc(onRequest)
	go userInputHandler()
	fmt.Printf("[PROXY LISTENING ON PORT 8080]\n")
	http.ListenAndServe(":8080", httpClient)
}

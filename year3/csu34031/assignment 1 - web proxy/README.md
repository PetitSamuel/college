## CSU34031 Advanced Telecommunications Assignment 1 -  Web Proxy Server

### Overall Structure

The program starts by launching a thread which will listen for user input as well as a client that will listen for http requests. Then, any request received on that port will be directed to a method that I wrote called "onRequest".

This method will first check to see if the request comes from a blocked domain. If it does then a response 403 Forbidden is returned. Otherwise it will either start a connexion for https or simply create a http client a send the request. The response is then forwarded back to the original sender.

The only difference for https is that a connection needs to be formed before any content can be exchange which is why the "onRequest" method makes sure to redirect such requests to the method which creates such connections, it is called "httpsHandler".

### Management Console
I made a function which constantly listens for user input which runs concurrently. The concurrent part is done quite simply in Go by using the keyword "go" in front of the function to execute, which essentially launches a really lightweight thread.

The actual function itself will listen for user input constantly, here is the list of commands it can execute:
- block < domain name >
- unblock < domain name >

If the user input does not begin with block or unblock then the command will not be supported and the program will then start to listen for the next input.

The actual domain blocking is done through an array of strings. When the program receives a request it will first make sure that the domain to send the request to is not in that array, if it is then the communication ends here and an error message is displayed, if not then the program resumes as usual.
Adding a new blocked domain is as simple as appending it to the array, deleting it consists of finding the index of the domain to delete and to remove it from the array. This is done by copying over all of the elements except the one in question.

### Caching Requests

I implemented caching fairly simply here by maintaining an map where the key is the endpoint of a request and the value is an instance of http.Response.
On every request received, the endpoint is extracted and the program check if there is a response in the map. If there is one then it is directly returned, if not then the flow of the function continues and a http request will be sent to that endpoint.

### Simultaneous requests

Thankfully, Go deals with concurency quite well and the http server can serve multiple requests concurently. 

### Code

```
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

```
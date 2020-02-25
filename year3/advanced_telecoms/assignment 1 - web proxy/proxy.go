package main

import (
	"bufio"
	"bytes"
	"errors"
	"fmt"
	"io"
	"net"
	"net/http"
	"net/http/httputil"
	"os"
	"strconv"
	"strings"
	"time"
)

const BLOCK_CMD = "block "
const UNBLOCK_CMD = "unblock "

var blocked []string
var cache map[string]cacheItem = make(map[string]cacheItem)

type cacheItem struct {
	response   []byte
	expiryTime time.Time
}

func newCacheItem(res []byte, exp time.Time) cacheItem {
	return cacheItem{
		response:   res,
		expiryTime: exp,
	}
}

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
	destTCP, destOk := dest.(*net.TCPConn)
	clientTCP, clientOK := client.(*net.TCPConn)
	if destOk && clientOK {
		go transfer(destTCP, clientTCP)
		go transfer(clientTCP, destTCP)
	}
}

func checkCache(r *http.Request) (*http.Response, error) {
	// placeholder
	var res *http.Response

	// check is in cache
	if r.Method != http.MethodGet {
		return res, errors.New("Not a get")
	}
	dumpedRequest, err := httputil.DumpRequest(r, false)
	if err != nil {
		return res, errors.New("[ERROR] Could not check if request is in cache - error while dumping request")
	}
	cachedResponse, ok := cache[string(dumpedRequest)]
	// request not in cache
	if !ok {
		return res, errors.New("Item not in cache")
	}

	// cache expired : remove it
	if cachedResponse.expiryTime.Sub(time.Now().Local()) < 0 {
		delete(cache, string(dumpedRequest))
		fmt.Printf("[INFO] Deleted expired cache\n")
		return res, errors.New("[ERROR] Cache entry expired. It was deleted.")
	}

	// response is stored as array of byte. Read it to http
	responseReader := bufio.NewReader(bytes.NewReader(cachedResponse.response))
	response, err := http.ReadResponse(responseReader, nil)
	if err != nil {
		fmt.Printf("[ERROR] Error while reading dumped response back to http response instance.")
		fmt.Println(err)
		return res, errors.New("[ERROR] Error while reading dumped response back to http response instance")
	}

	fmt.Printf("[FOUND RESPONSE FROM CACHE]\n")
	return response, nil
}

func cacheResponse(r *http.Request, res *http.Response, expiryTime time.Time) {
	// only cache get methods
	if r.Method != http.MethodGet {
		return
	}
	dumpRequest, err := httputil.DumpRequest(r, false)
	if err != nil {
		fmt.Printf("[ERROR] Could not dump request")
		fmt.Println(err)
		return
	}
	dumpResponse, err := httputil.DumpResponse(res, true)
	if err != nil {
		fmt.Printf("[ERROR] Could not cache the response (with cache body = true)")
		fmt.Println(err)
		return
	}
	cache[string(dumpRequest)] = newCacheItem(dumpResponse, expiryTime)
	fmt.Printf("[SUCCESS] Cached response\n")
}

// Handles http requests
func onRequest(w http.ResponseWriter, r *http.Request) {
	start := time.Now()

	fmt.Printf("[RECEIVED A REQUEST] %s -- %s\n", r.Method, r.URL)
	if isDomainBlocked(r.Host) {
		fmt.Printf("[TRIED TO ACCESS BLACKLISTED DOMAIN] Request blocked - %s\n", r.Host)
		w.WriteHeader(http.StatusForbidden)
		w.Write([]byte("403 FORBIDDEN - TRIED TO ACCESS BLACKLISTED DOMAIN\r\n\r\n"))
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

	// Create new http request
	r2, err := http.NewRequest(r.Method, url, r.Body)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		fmt.Printf("[ERROR BAD REQUEST] Could not write headers to new request: %v", err)
		return
	}

	r2.Header = r.Header
	res, err := checkCache(r2)
	isFromCache := err == nil

	// res is not in cache, send request
	if !isFromCache {
		// Round trip is used for single communications instead of having a client
		res, err = http.DefaultTransport.RoundTrip(r2)
		if err != nil {
			fmt.Printf("[ERROR] Could not forward request")
			w.WriteHeader(http.StatusBadGateway)
			return
		}
	}

	fmt.Printf("[GOT RESPONSE TO REQUEST] Status - %s\n", res.Status)

	// look for no-cache or max-age headers
	//putInCache := !isFromCache
	var maxAge string = ""
	cacheHeaders := res.Header["Cache-Control"]
	if cacheHeaders != nil && len(cacheHeaders) > 0 {
		vals := strings.SplitN(cacheHeaders[0], ", ", -1)
		for _, item := range vals {
			if item == "no-cache" {
				//putInCache = false
			} else if strings.Contains(item, "max-age") {
				maxAge = item
			}
		}
	}

	// set expiry time for cache - if none specified keep for 24h
	expiryCacheTime := time.Now().Local()
	if maxAge != "" && !isFromCache {
		splitMaxAge := strings.SplitN(maxAge, "=", -1)
		seconds, err := strconv.Atoi(splitMaxAge[1])
		if err != nil {
			expiryCacheTime = expiryCacheTime.Add(time.Hour * 24)
		} else {
			expiryCacheTime = expiryCacheTime.Add(time.Second * time.Duration(seconds))
		}
	} else {
		expiryCacheTime = expiryCacheTime.Add(time.Hour * 24)
	}

	fmt.Printf("[INFO] Expiry Time for cache: ")
	fmt.Println(expiryCacheTime)

	// Remove proxy header and copy other headers to return to client.
	header := w.Header()
	res.Header.Del("Proxy-Connection")
	for key, val := range res.Header {
		header[key] = val
	}
	w.WriteHeader(res.StatusCode)

	// should check from putInCache here however this breaks certain calls for some reason
	if !isFromCache {
		cacheResponse(r2, res, expiryCacheTime)
		res.Body.Close()
	}
	if _, err := io.Copy(w, res.Body); err != nil {
		fmt.Printf("[ERROR] Could not proxy request %v", err)
	}
	fmt.Printf("EXECUTION TIME - %s\n\n", time.Since(start))
}

// remove specified string from slice containing blocked domains.
func unblockDomain(domain string) bool {
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
		if strings.Contains(domain, item) {
			return true
		}
	}
	return false
}

func blockDomain(domain string) {
	if !isDomainBlocked(domain) {
		blocked = append(blocked, domain)
		fmt.Printf("[SUCCESS] Blocked domain %s\n", domain)
	}
}

// Continuously obtain user input and execute block / unblock domain actions.
func userInputHandler() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		input := scanner.Text()
		// get text as lowercase & trim
		input = strings.ToLower(strings.TrimSpace(input))
		len := len(input)
		if len > 6 && input[0:6] == BLOCK_CMD {
			var domain string = input[6:]
			blockDomain(domain)
		} else if len > 8 && input[0:8] == UNBLOCK_CMD {
			var found = unblockDomain(input[8:])
			if !found {
				fmt.Printf("[ERROR] Tried to unblock domain that was not blocked: %s\n", input[8:])
			}
		} else {
			fmt.Printf("[ERROR] Command not supported : %s\n", input)
		}
	}
}

func main() {
	fmt.Printf("[STARTING PROXY]\n")
	httpClient := http.HandlerFunc(onRequest)
	go userInputHandler()
	fmt.Printf("[PROXY LISTENING ON PORT 8080]\n")
	http.ListenAndServe(":8080", httpClient)
}

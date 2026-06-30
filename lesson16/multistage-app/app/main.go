package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "<h1>Hello! This is a Multistage Go Application built in Docker!</h1>")
	})
	fmt.Println("Server is running on port 8080...")
	http.ListenAndServe(":8080", nil)
}

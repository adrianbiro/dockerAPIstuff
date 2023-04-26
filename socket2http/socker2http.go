package main

import (
	"io"
	"net"
	"os"
)

// TODO add error
func main() {
	// Set up the TCP listener
	host := ""
	port := "2376"
	listener, err := net.Listen("tcp", net.JoinHostPort(host, port))
	if err != nil {
		panic(err)
	}
	defer listener.Close()

	// Wait for incoming connections and forward data to the Unix socket
	for {
		conn, err := listener.Accept()
		if err != nil {
			panic(err)
		}

		go func(conn net.Conn) {
			defer conn.Close()

			// Connect to the Unix socket
			unixSockPath := "/run/docker.sock"
			unixConn, err := net.Dial("unix", unixSockPath)
			if err != nil {
				panic(err)
			}
			defer unixConn.Close()

			// Forward data between the two sockets
			go func() {
				_, err := io.Copy(unixConn, conn)
				if err != nil {
					os.Exit(1)
				}
			}()
			_, err = io.Copy(conn, unixConn)
			if err != nil {
				os.Exit(1)
			}
		}(conn)
	}
}

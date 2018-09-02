package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"
	"github.com/slankdev/frr"
)

func main() {
	fmt.Println("Starting frr interpreter daemon")

	frr.Main()
	sigs := make(chan os.Signal, 1)
	done := make(chan bool)

	signal.Ignore(syscall.SIGWINCH)
	signal.Notify(sigs, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-sigs
		done <- true
	}()
	<-done
}

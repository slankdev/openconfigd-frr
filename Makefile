
PREF = $(GOPATH)/src/github.com/slankdev/frr

.PHONY: usage frrd openconfigd kill all

usage:
	@echo "Usage:"
	@echo "  make frrd"
	@echo "  make openconfigd"

frrd:
	sudo go run $(PREF)/frrd/main.go

openconfigd:
	sudo $(GOPATH)/bin/openconfigd -y $(PREF)/yang

kill:
	sudo killall frrd
	sudo killall openconfigd



PREF=/lib/systemd/system

usage:
	@echo "Usage:"
	@echo "   make [usage]"
	@echo "   make install"
	@echo "   make uninstall"

install:
	cp frrd.service $(PREF)/frrd.service
	cp openconfigd.service $(PREF)/openconfigd.service

uninstall:
	rm $(PREF)/frrd.service
	rm $(PREF)/openconfigd.service


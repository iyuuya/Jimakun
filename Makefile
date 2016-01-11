CC=clang # or gcc

PREFIX=~/

FRAMEWORKS:= -framework Foundation -framework AppKit
LIBRARIES:= -lobjc

TARGET=jimakun
SOURCE=MYLabel.m SubtitleWindowController.m AppDelegate.m main.m

CFLAGS=-Wall -Werror -g -v $(SOURCE)
LDFLAGS=$(LIBRARIES) $(FRAMEWORKS)
OUT=-o $(TARGET)

all:
	$(CC) $(CFLAGS) $(LDFLAGS) $(OUT)
clean:
	rm -rf $(TARGET).dSYM
allclean: clean
	rm $(TARGET)
install: all
	mkdir -p $(PREFIX)/bin
	cp $(TARGET) $(PREFIX)/bin/jimakun
package: all
	mkdir -p jimakun-$(VERSION)
	cp $(TARGET) jimakun-$(VERSION)/
	cp README.md jimakun-$(VERSION)/
	cp LICENSE.txt jimakun-$(VERSION)/
	zip -r jimakun.zip jimakun-$(VERSION)

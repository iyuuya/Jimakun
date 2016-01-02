CC=clang # or gcc

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

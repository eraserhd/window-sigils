
CC		= xcrun clang
CFLAGS		= -framework Cocoa
SOURCES		= $(wildcard *.c)
PROGRAMS	= $(basename $(SOURCES))
PREFIX		= /usr/local

all: $(PROGRAMS)

install: all
	mkdir -p $(PREFIX)/bin
	for p in $(PROGRAMS); do \
	  cp $$p $(PREFIX)/bin/$$p; \
	done

%: %.c
	$(CC) $(CFLAGS) -o $* $< 


prefix		= /usr/local

SOURCES		= $(wildcard *.c)
PROGRAMS	= $(basename $(SOURCES))
CFLAGS		+= -Werror
LDFLAGS		+= -framework CoreGraphics -framework AppKit -lobjc

all: $(PROGRAMS)

install: all
	mkdir -p $(prefix)/bin
	for p in $(PROGRAMS); do \
	  cp $$p $(prefix)/bin/$$p; \
	done



CC		= xcrun clang
CFLAGS		= -framework Cocoa
SOURCES		= $(wildcard *.c)
PROGRAMS	= $(basename $(SOURCES))

all: $(PROGRAMS)

%: %.c
	$(CC) $(CFLAGS) -o $* $< 

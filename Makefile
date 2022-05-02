

CC		= xcrun clang
CFLAGS		= -framework Cocoa
SOURCES		= $(wildcard *.m)
PROGRAMS	= $(basename $(SOURCES))

all: $(PROGRAMS)

%: %.m
	$(CC) $(CFLAGS) -o $* $< 

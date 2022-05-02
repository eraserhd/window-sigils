#include <stdio.h>
#include <Cocoa/Cocoa.h>
#include <Carbon/Carbon.h>

const char *PREFIX = "https://github.com/eraserhd/window-sigils/blob/main/docs/vocab.adoc#";

int main(int argc, char *argv[])
{
    printf("\
{\n\
    \"@context\": {\n\
        \"@version\": \"1.1\"\n\
    },\n\
    \"windows\": [\n\
        ");

    CFArrayRef windowListArray = CGWindowListCreate(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);
    NSArray *windows = CFBridgingRelease(CGWindowListCreateDescriptionFromArray(windowListArray));
    CFRelease(windowListArray);

    BOOL isFirst = YES;
    for (NSDictionary *window in windows)
    {
        printf("%s\n\
        {\n\
            \"@type\": \"%sWindow\"\n\
        }", isFirst ? "" : ",", PREFIX);
        isFirst = NO;
    }
    [windows release];

    printf("\n\
    ]\n\
}\n");

    exit(0);
}

// Useful @id for all windows
// Correct vocab for rectangles/geometry

// Add screens

// What's the root object?

// Why are we not getting name?
// nixpkgs derviation builds

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
        NSDictionary *bounds = [window objectForKey:@"kCGWindowBounds"];
        printf("%s\n\
        {\n\
            \"@type\": \"%sWindow\",\n\
            \"number\": \"%s\",\n\
            \"ownerName\": \"%s\",\n\
            \"ownerPID\": \"%s\",\n\
            \"bounds\": {\n\
                \"x\": %lld,\n\
                \"y\": %lld,\n\
                \"width\": %lld,\n\
                \"height\": %lld\n\
            }\n\
        }",
            isFirst ? "" : ",",
            PREFIX,
            [[[window objectForKey:@"kCGWindowNumber"] stringValue] cStringUsingEncoding:NSUTF8StringEncoding],
            [[window objectForKey:@"kCGWindowOwnerName"] cStringUsingEncoding:NSUTF8StringEncoding],
            [[[window objectForKey:@"kCGWindowOwnerPID"] stringValue] cStringUsingEncoding:NSUTF8StringEncoding],
            [[bounds objectForKey:@"X"] longLongValue],
            [[bounds objectForKey:@"Y"] longLongValue],
            [[bounds objectForKey:@"Width"] longLongValue],
            [[bounds objectForKey:@"Height"] longLongValue]
        );
        isFirst = NO;
    }
    [windows release];

    printf("\n\
    ]\n\
}\n");
    exit(0);
}

// Useful @id for all windows

// Add screens

// Why are we not getting name?
// nixpkgs derviation builds
// Make plain C?

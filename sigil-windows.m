#include <Cocoa/Cocoa.h>
#include <Carbon/Carbon.h>

const NSString *PREFIX = @"https://github.com/eraserhd/window-sigils/blob/main/docs/vocab.adoc#";

static NSDictionary* make_context()
{
    static const NSString *keys[] = {
        @"@version",
    };
    static const NSString *objects[] = {
        @"1.1",
    };
    return [[NSDictionary alloc] initWithObjects:objects forKeys:keys count:(NSUInteger)(sizeof(keys)/sizeof(keys[0]))];
}

static NSDictionary* make_window(NSDictionary* orig)
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:[NSString stringWithFormat:@"%@%@", PREFIX, @"Window"] forKey:@"@type"];
    return result;
}

static NSArray *get_windows()
{
    CFArrayRef windowListArray = CGWindowListCreate(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);
    NSArray *windows = CFBridgingRelease(CGWindowListCreateDescriptionFromArray(windowListArray));
    CFRelease(windowListArray);

    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[windows count]];

    for (NSDictionary *window in windows)
    {
        NSDictionary *modified_window = make_window(window);
        [result addObject:modified_window];
        [modified_window release];
    }

    [windows release];
    return result;
}


int main(int argc, char *argv[])
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

    NSDictionary *context = make_context();
    [result setObject:context forKey:@"@context"];
    [context release];

    NSArray *windows = get_windows();
    [result setObject:windows forKey:@"windows"];
    [windows release];

    NSOutputStream *output = [NSOutputStream outputStreamToFileAtPath:@"/dev/stdout" append:NO];
    [output open];
    [NSJSONSerialization writeJSONObject:result toStream:output options:NSJSONWritingPrettyPrinted error:nil];

    [output write:(const uint8_t*)"\n" maxLength:1];
    [output close];
    [output release];
    exit(0);
}

// Useful @id for all windows
// @type for all windows
// Correct vocab for rectangles/geometry

// Add screens

// What's the root object?

// Why are we not getting name?
// nixpkgs derviation builds

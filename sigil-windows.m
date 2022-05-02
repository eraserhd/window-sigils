#include <Cocoa/Cocoa.h>
#include <Carbon/Carbon.h>

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

int main(int argc, char *argv[])
{
    CFArrayRef windowListArray = CGWindowListCreate(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);
    NSArray *windows = CFBridgingRelease(CGWindowListCreateDescriptionFromArray(windowListArray));
    CFRelease(windowListArray);

    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

    NSDictionary *context = make_context();
    [result setObject:context forKey:@"@context"];
    [context release];

    [result setObject:@"foo" forKey:@"@id"];
    [result setObject:windows forKey:@"windows"];

    for (NSDictionary *window in windows)
    {
    }

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

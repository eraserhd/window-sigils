#include <stdio.h>
#include <Cocoa/Cocoa.h>
#include <Carbon/Carbon.h>

static long long number_value(CFNumberRef ref)
{
    long long value = 0;
    CFNumberGetValue(ref, kCFNumberLongLongType, &value);
    return value;
}

int main(int argc, char *argv[])
{
    CFArrayRef windowListArray = CGWindowListCreate(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);
    CFArrayRef windows = (CFArrayRef)CFBridgingRelease(CGWindowListCreateDescriptionFromArray(windowListArray));
    CFRelease(windowListArray);
    for (CFIndex i = 0; i < CFArrayGetCount(windows); i++)
    {
        CFDictionaryRef window = CFArrayGetValueAtIndex(windows, i);
        CFDictionaryRef bounds = CFDictionaryGetValue(window, kCGWindowBounds);
        printf("%5lld %6lld %6lld %6lld %6lld %5lld\n",
               number_value(CFDictionaryGetValue(window, kCGWindowNumber)),
               number_value(CFDictionaryGetValue(bounds, @"X")),
               number_value(CFDictionaryGetValue(bounds, @"Y")),
               number_value(CFDictionaryGetValue(bounds, @"Width")),
               number_value(CFDictionaryGetValue(bounds, @"Height")),
               number_value(CFDictionaryGetValue(window, kCGWindowOwnerPID)));
    }
    CFRelease(windows);
    exit(0);
}

// Why are we not getting name?
// nixpkgs derviation builds

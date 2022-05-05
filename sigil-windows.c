#include <stdio.h>
#include <CoreFoundation/CoreFoundation.h>
#include <CoreGraphics/CoreGraphics.h>


static long long number_value(CFNumberRef ref)
{
    long long value = 0;
    CFNumberGetValue(ref, kCFNumberLongLongType, &value);
    return value;
}

int main(int argc, char *argv[])
{
    CFArrayRef windowListArray = CGWindowListCreate(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);
    CFArrayRef windows = CGWindowListCreateDescriptionFromArray(windowListArray);
    CFRelease(windowListArray);
    for (CFIndex i = 0; i < CFArrayGetCount(windows); i++)
    {
        CFDictionaryRef window = CFArrayGetValueAtIndex(windows, i);
        CFDictionaryRef bounds = CFDictionaryGetValue(window, kCGWindowBounds);
        printf("%5lld %6lld %6lld %6lld %6lld %5lld\n",
               number_value(CFDictionaryGetValue(window, kCGWindowNumber)),
               number_value(CFDictionaryGetValue(bounds, CFSTR("X"))),
               number_value(CFDictionaryGetValue(bounds, CFSTR("Y"))),
               number_value(CFDictionaryGetValue(bounds, CFSTR("Width"))),
               number_value(CFDictionaryGetValue(bounds, CFSTR("Height"))),
               number_value(CFDictionaryGetValue(window, kCGWindowOwnerPID)));
    }
    CFRelease(windows);
    exit(0);
}

// Why are we not getting name?
// nixpkgs derviation builds

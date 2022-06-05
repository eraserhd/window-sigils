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
    printf("PID\tWindow\tX\tY\tWidth\tHeight\n");

    CFArrayRef windowListArray = CGWindowListCreate(kCGWindowListOptionOnScreenOnly|kCGWindowListExcludeDesktopElements, kCGNullWindowID);
    CFArrayRef windows = CGWindowListCreateDescriptionFromArray(windowListArray);
    CFRelease(windowListArray);
    for (CFIndex i = 0; i < CFArrayGetCount(windows); i++)
    {
        CFDictionaryRef window = CFArrayGetValueAtIndex(windows, i);
        CFDictionaryRef bounds = CFDictionaryGetValue(window, kCGWindowBounds);

        // CFTypeRef value;
        // NSAccessibilityTitleAttribute ()
        // AXUIElementCopyAttributeValue(elementRef?, (__bridge CFStringRef)property, &value)
        // CFBridgingRelease(value);
        printf("%lld\t%lld\t%lld\t%lld\t%lld\t%lld\n",
               number_value(CFDictionaryGetValue(window, kCGWindowOwnerPID)),
               number_value(CFDictionaryGetValue(window, kCGWindowNumber)),
               number_value(CFDictionaryGetValue(bounds, CFSTR("X"))),
               number_value(CFDictionaryGetValue(bounds, CFSTR("Y"))),
               number_value(CFDictionaryGetValue(bounds, CFSTR("Width"))),
               number_value(CFDictionaryGetValue(bounds, CFSTR("Height"))));
    }
    CFRelease(windows);
    exit(0);
}

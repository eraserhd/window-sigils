#include <objc/objc.h>
#include <objc/message.h>
#include <objc/runtime.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/types.h>

#include <CoreFoundation/CoreFoundation.h>
#include <CoreGraphics/CoreGraphics.h>

int main(int argc, char *argv[])
{
    Class NSWorkspace = objc_getClass("NSWorkspace");
    SEL bundleIdentifier = sel_registerName("bundleIdentifier");
    SEL isActive = sel_registerName("isActive");
    SEL isHidden = sel_registerName("isHidden");
    SEL localizedName = sel_registerName("localizedName");
    SEL processIdentifier = sel_registerName("processIdentifier");
    SEL runningApplications = sel_registerName("runningApplications");
    SEL sharedWorkspace = sel_registerName("sharedWorkspace");

    printf("PID\tActive?\tHidden?\tBundle ID\tName\n");

    id ws = objc_msgSend((id)NSWorkspace, sharedWorkspace);
    CFArrayRef apps = (CFArrayRef)objc_msgSend(ws, runningApplications);
    for (CFIndex i = 0; i < CFArrayGetCount(apps); i++)
    {
        id app = (id)CFArrayGetValueAtIndex(apps, i);

        CFStringRef bundleId = (CFStringRef)objc_msgSend(app, bundleIdentifier);
        const char *bundle_id = CFStringGetCStringPtr(bundleId, kCFStringEncodingUTF8);
        if (!bundle_id)
        {
            bundle_id = "-";
        }

        pid_t pid = (intptr_t)objc_msgSend(app, processIdentifier);

        CFStringRef nameStr = (CFStringRef)objc_msgSend(app, localizedName);
        const char *name = CFStringGetCStringPtr(nameStr, kCFStringEncodingUTF8);
        if (!name)
        {
            name = "-";
        }

        char active = objc_msgSend(app, isActive) ? 'Y' : 'N';
        char hidden = objc_msgSend(app, isHidden) ? 'Y' : 'N';

        printf("%d\t%c\t%c\t%s\t%s\n", pid, active, hidden, bundle_id, name);
        if (bundleId)
        {
            CFRelease(bundleId);
        }
        if (nameStr)
        {
            CFRelease(nameStr);
        }
    }
    CFRelease(apps);
    exit(0);
}

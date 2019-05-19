# rgbclocksaver
Simple clock screen saver with a glitch aesthetic and aspirations to minimal code.

Pretend the current time is a hexadecimal rgb color and use it for
the background fill color. Treating hours/minutes/seconds as hex rgb
causes color artifacts in the background color transition that convey
information about the passage of time:

Every second,        the color turns a smidgeon more blue.

Every 10 seconds,    the color turns slightly more blue.

Every minute,        the color turns somewhat more green.

Every 10 minutes,    the color turns a lot more green.

Every hour,          the color turns much more red.

Every 10 hours,      the color turns very much more red.

At midnight, everything goes black.

![preview](/preview.png)

#!/bin/sh
osascript -s o << END
    tell application "Safari"
        do JavaScript "window.location.reload();" in front document
    end tell
END

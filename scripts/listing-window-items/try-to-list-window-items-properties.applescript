#!/usr/bin/osascript

tell application "System Events"
    tell process "ControlCenter"
        set mbiControlCentre to a reference to first item of (get menu bar items of menu bar 1) whose description is "Control Centre"
        if mbiControlCentre exists then
            click mbiControlCentre
        else
            error "Couldn't find Control Centre on Menu Bar"
            return
        end if

        repeat with i in (get entire contents of group 1 of window "Control Centre")
            log (get description of i)
            log (get name of i)
            log (get properties of i)
            log (first item of i)
            log "-"
        end repeat
    end tell
end tell

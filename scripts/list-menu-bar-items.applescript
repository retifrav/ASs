#!/usr/bin/osascript

tell application "System Events"
    tell process "ControlCenter"
        log "Available menu bar items:"
        repeat with mbi in (get menu bar items of menu bar 1)
            log "- " & (get description of mbi)
        end repeat
    end tell
    return
end tell

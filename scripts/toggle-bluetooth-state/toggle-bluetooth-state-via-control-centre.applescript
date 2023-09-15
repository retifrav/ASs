#!/usr/bin/osascript

on run argv
    -- 0 - turn OFF
    -- 1 - turn ON
    set turnOn to 0

    set argc to count argv

    if argc > 1 then
        error "Too many arguments provided, expected only one: turn ON (1) or OFF (0)"
    end if

    if argc is 0 then
        set turnOn to 0
    else
        set turnOn to first item of argv
    end if

    toggleBluetooth(turnOn)

    return -- otherwise it will also print the last command
end run

on toggleBluetooth(turnOn)
    -- there is no list of integers in AppleScript, so need to cast to string and check in a list of strings
    if turnOn as string is not in {"0", "1"} then
        set msg to "Wrong value, Bluetooth state can be only 0 or 1"
        displayMsg(msg, missing value)
        error msg
    end if

    set turnOn to turnOn as integer as boolean

    tell application "System Events"
        tell process "ControlCenter"
            set mbiControlCentre to a reference to first item of (get menu bar items of menu bar 1) whose description is "Control Centre"
            if mbiControlCentre exists then
                click mbiControlCentre
            else
                error "Couldn't find Control Centre on Menu Bar"
            end if

            # no IDs or labels, have to rely on ordinals
            set tglBluetooth to checkbox 3 of group 1 of window "Control Centre"
            tell tglBluetooth
                if (its value as boolean) and not turnOn then
                    click tglBluetooth
                else if not (its value as boolean) and turnOn then
                    click tglBluetooth
                else
                    set bluetootState to "OFF"
                    if (its value as boolean) then set bluetootState to "ON"
                    log "The Bluetooth state is already " & bluetootState
                end if
            end tell

            key code 53 -- ESC
        end tell
    end tell
end toggleBluetooth

on displayMsg(msg, autoCloseTimeout)
    if autoCloseTimeout is missing value then set autoCloseTimeout to 0
    display dialog msg buttons {"OK"} default button "OK" giving up after autoCloseTimeout
end displayMsg

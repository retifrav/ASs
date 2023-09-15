#!/usr/bin/osascript

on run argv
    -- 1 - No One
    -- 2 - Contact Only
    -- 3 - Everyone
    set discoverabilityLevel to 0

    -- repeat with arg in argv -- argv is a list {}, even if there is only one argument
    --     displayMsg(arg, missing value)
    -- end repeat

    set argc to count argv

    if argc > 1 then
        error "Too many arguments provided, expected only one (discoverability level)"
    end if

    if argc is 0 then
        set discoverabilityLevel to 1
    else
        set discoverabilityLevel to first item of argv
    end if

    applyDiscoverabilityLevel(discoverabilityLevel)

    return -- otherwise it will also print the last command
end run

on applyDiscoverabilityLevel(discoverabilityLevel)
    -- there is no list of integers in AppleScript, so need to cast to string and check in a list of strings
    if discoverabilityLevel as string is not in {"1", "2", "3"} then
        set msg to "Wrong value, discoverability level can be only 1, 2 or 3"
        displayMsg(msg, missing value)
        error msg
    end if
    -- for some reason need to explicitly cast it to integer, otherwise click won't actually click
    set discoverabilityLevel to discoverabilityLevel as integer

    -- check if user configured toggling off Bluetooth as well
    set toggleOffBluetooth to (system attribute "TOGGLE_OFF_BLUETOOTH") as integer

    -- first set desired AirDrop discoverability level
    toggleAirDropViaMenuBar(discoverabilityLevel)

    -- and then optionally disable Bluetooth
    if discoverabilityLevel is 1 and toggleOffBluetooth is 1 then
        toggleBluetoothOff()
    end if
end applyDiscoverabilityLevel

on toggleAirDropViaMenuBar(discoverabilityLevel)
    tell application "System Events"
        tell process "ControlCenter"
            try -- via Menu Bar icon first
                -- check if user has added AirDrop to Menu Bar
                set mbiAirDrop to a reference to first item of (get menu bar items of menu bar 1) whose description is "AirDrop"
                if mbiAirDrop exists then
                    -- log "[DEBUG] Found AirDrop icon on Menu Bar"
                    click mbiAirDrop
                else
                    error "There is no AirDrop icon on Menu Bar, you need to add it there first"
                end if

                -- no IDs or labels, have to rely on ordinals
                set tglAirDrop to first checkbox of group 1 of window "Control Centre"
                if discoverabilityLevel is 1 then
                    tell tglAirDrop
                        if (its value as boolean) then click tglAirDrop
                    end tell
                else
                    tell tglAirDrop
                        if not (its value as boolean) then click tglAirDrop
                    end tell

                    set tglAirDropDiscoverability to checkbox discoverabilityLevel of group 1 of window "Control Centre"
                    tell tglAirDropDiscoverability
                        if not (its value as boolean) then click tglAirDropDiscoverability
                    end tell
                end if
            on error ex -- fallback to Control Centre
                -- log "[DEBUG] " & ex
                try
                    -- disabled, see comments on clicking checkbox 4 below
                    --
                    -- set mbiControlCentre to a reference to first item of (get menu bar items of menu bar 1) whose description is "Control Centre"
                    -- if mbiControlCentre exists then
                    --     click mbiControlCentre
                    -- else
                    --     error "Couldn't find Control Centre on Menu Bar"
                    -- end if
                    --
                    -- no IDs or labels, have to rely on ordinals
                    -- checkbox 4 is the AirDrop icon item, which just toggles the state ON and OFF
                    -- without openning options, but we want to click on the text, because then
                    -- the options menu will appear, and that is not possible to do through Accessibility
                    --
                    -- TODO: when this menu becomes accessible, implement logic for setting desired state instead of the current "dumb" toggling
                    -- click checkbox 4 of group 1 of window "Control Centre"
                    --
                    error "AirDrop options menu is not available through Accessibility, falling back to Finder window"
                on error ex
                    -- log "[DEBUG] " & ex
                    my toggleAirDropViaFinder(discoverabilityLevel)
                    return -- otherwise it will get to pressing ESC below
                end try
            end try

            key code 53 -- ESC
        end tell
    end tell
end toggleAirDropViaMenuBar

on toggleAirDropViaFinder(discoverabilityLevel)
    tell application "Finder"
        make new Finder window
        activate
    end tell

    tell application "System Events" to tell process "Finder"
        keystroke "R" using {command down, shift down}
        -- check if Bluetooth is disabled
        set bluetoothButton to a reference to (first button of splitter group 1 of window 1) -- neither of these works: whose name is "Turn On Bluetooth" / whose value of attribute "Title" is "Turn On Bluetooth"
        if bluetoothButton exists then
            -- for some reason cannot put both of these conditions into one if statement
            if discoverabilityLevel is not 1 then
                click bluetoothButton
            else
                -- Bluetooth is off and selected discoverability level is 1, won't enable Bluetooth then
                tell application "Finder"
                    close first window
                end tell
                return
            end if
        end if
        -- open the "Allow me to be discovered by" dropdown
        click button 1 of splitter group 1 of splitter group 1 of window 1
        -- select the discoverability level
        click radio button discoverabilityLevel of pop over 1 of splitter group 1 of splitter group 1 of window 1

        -- close current Finder window, otherwise they'll spam the user eventually
        tell application "Finder"
            close first window
        end tell
    end tell
end toggleAirDropViaFinder

on toggleBluetoothOff()
    tell application "System Events"
        tell process "ControlCenter"
            try -- via Menu Bar icon first
                -- check if user has added Bluetooth to Menu Bar
                set mbiBluetooth to a reference to first item of (get menu bar items of menu bar 1) whose description is "Bluetooth"
                if mbiBluetooth exists then
                    -- log "[DEBUG] Found Bluetooth icon on Menu Bar"
                    click mbiBluetooth
                else
                    error "There is no Bluetooth icon on Menu Bar, you need to add it there first"
                end if

                -- no IDs or labels, have to rely on ordinals
                set tglBluetooth to first checkbox of group 1 of window "Control Centre"
                tell tglBluetooth
                    if (its value as boolean) then click tglBluetooth
                end tell
            on error ex -- fallback to Control Centre
                -- log "[DEBUG] " & ex
                set mbiControlCentre to a reference to first item of (get menu bar items of menu bar 1) whose description is "Control Centre"
                if mbiControlCentre exists then
                    click mbiControlCentre
                else
                    -- there is no fallback for this scenario, so the script should fail
                    error "Couldn't find Control Centre on Menu Bar"
                end if

                -- no IDs or labels, have to rely on ordinals
                set tglBluetooth to checkbox 3 of group 1 of window "Control Centre"
                tell tglBluetooth
                    if (its value as boolean) then click tglBluetooth
                end tell
            end try

            key code 53 -- ESC
        end tell
    end tell
end toggleBluetoothOff

on displayMsg(msg, autoCloseTimeout)
    if autoCloseTimeout is missing value then set autoCloseTimeout to 0
    display dialog msg buttons {"OK"} default button "OK" giving up after autoCloseTimeout
end displayMsg

# AppleScripts

My **A**pple**S**cript**s** collection

<!-- MarkdownTOC -->

- [write-to-log](#write-to-log)
- [mail-message-count](#mail-message-count)
- [ping-and-reconnect](#ping-and-reconnect)
- [play-sound](#play-sound)
- [process-files-with-ffmpeg](#process-files-with-ffmpeg)
- [Files and folders](#files-and-folders)
    - [get-extension](#get-extension)
    - [get-path-without-extension](#get-path-without-extension)
    - [get-folder-name](#get-folder-name)
- [Listing GUI controls](#listing-gui-controls)
    - [list-menu-bar-items](#list-menu-bar-items)
    - [try-to-list-window-items-properties](#try-to-list-window-items-properties)
- [toggle-bluetooth-state-via-menu-bar-icon](#toggle-bluetooth-state-via-menu-bar-icon)

<!-- /MarkdownTOC -->

### write-to-log

Shared-ish script with logging function to call from other scripts. It logs strings to the specified text file.

### mail-message-count

![AppleScript mail message count](/img/mail-message-count.png?raw=true "AppleScript mail message count")

The script shows message count for each mailbox in all accounts. The information is displayed in the log. You can get all messages count, or only unread ones, or only flagged ones by re-commenting corresponding lines.

### ping-and-reconnect

This one pings some website URL to check internet connection, and if ping fails, then script restarts the network interface (turns off and on again). It helps when you are connected via WiFi and suddenly everything loses connection.

### play-sound

Plays a sound file with `afplay`. Can be used to play notifications when finishing some task.

### process-files-with-ffmpeg

Gets a list of files and iterates through them, processing each with FFmpeg. Here's [an article](https://retifrav.github.io/blog/2016/08/25/macos-automator-ffmgeg-files/) about creating a Service based on that.

### Files and folders

#### get-extension

Given the filename `/Users/yourname/temp/log.txt` returns `txt`.

#### get-path-without-extension

Given the filename `/Users/yourname/temp/log.txt` returns `/Users/yourname/temp/log`.

#### get-folder-name

Given the path `/Users/yourname/temp/` returns `temp`.

### Listing GUI controls

#### list-menu-bar-items

``` sh
$ sw_vers -productVersion
13.5.2

$ osascript ./list-menu-bar-items.applescript
Available menu bar items
- Clock
- Control Centre
- Wi‑Fi, connected, 3 bars
- Battery
- Bluetooth
- Shortcuts
```

#### try-to-list-window-items-properties

``` sh
$ sw_vers -productVersion
13.5.2

$ osascript ./try-to-list-window-items-properties.applescript
toggle button
missing value
class:checkbox, minimum value:missing value, orientation:missing value, position:1386, 46, accessibility description:missing value, role description:toggle button, focused:missing value, title:missing value, size:134, 41, help:missing value, entire contents:, enabled:true, maximum value:missing value, role:AXCheckBox, value:1, subrole:AXToggle, selected:missing value, name:missing value, description:toggle button
item 1 of checkbox 1 of group 1 of window Control Centre of application process ControlCenter
-
toggle button
missing value
class:checkbox, minimum value:missing value, orientation:missing value, position:1530, 40, accessibility description:missing value, role description:toggle button, focused:missing value, title:missing value, size:134, 62, help:missing value, entire contents:, enabled:true, maximum value:missing value, role:AXCheckBox, value:0, subrole:AXToggle, selected:missing value, name:missing value, description:toggle button
item 1 of checkbox 2 of group 1 of window Control Centre of application process ControlCenter
-
...
```

Might fail in different scenarios because of the wrong index, or inability to get "every item", or else

### toggle-bluetooth-state-via-menu-bar-icon

Toggles Bluetooth state via Menu Bar icon (*requires user to add Bluetooth icon on Menu Bar via Control Centre Modules in System Settings*):

``` sh
$ sw_vers -productVersion
13.5.2

$ osascript ./toggle-bluetooth-state-via-menu-bar-icon.applescript 1
```

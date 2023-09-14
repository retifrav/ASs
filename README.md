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
- [list-menu-bar-items](#list-menu-bar-items)

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

### list-menu-bar-items

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

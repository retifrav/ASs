# input contains a list of files
repeat with i in input
    # get path to file
    set fname to POSIX path of i
    # using axe cut the extension and quotes from end
    set o to text 1 thru -5 of fname
    # run ffmpeg for a file
    do shell script "/path/to/ffmpeg -i \"" & fname & "\" -crf 18 -y \"" & o & ".mov\""
end repeat
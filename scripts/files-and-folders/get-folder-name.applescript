on getFolderName(fname)
	set folderPath to ""
	set defaultTID to AppleScript's text item delimiters
	try
		#set fname to "/Users/yourname/temp/some/"
		set AppleScript's text item delimiters to {"/"}
		set fnameSeparated to fname's text items
		set folderPath to last item of reverse of rest of reverse of fnameSeparated
		set AppleScript's text item delimiters to defaultTID
	on error
		set AppleScript's text item delimiters to defaultTID
	end try
	return folderPath
end getFolderName
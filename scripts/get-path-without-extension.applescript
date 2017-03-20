on getPathWithoutExtension(fname)
	set pathWithoutExtension to ""
	set defaultTID to AppleScript's text item delimiters
	try
		# debug
		#set fname to "/Users/yourname/temp/some.log"
		# set new delimiters to "."
		set AppleScript's text item delimiters to {"."}
		# get the list of fname items separated by the new delimiter
		set fnameSeparated to fname's text items
		# some magic here to exclude the last item which is extension
		set pathWithoutExtension to reverse of rest of reverse of fnameSeparated as string
		# return original delimiters back on error
		set AppleScript's text item delimiters to defaultTID
	on error
		# just in case, return original delimiters back on error
		set AppleScript's text item delimiters to defaultTID
	end try
	return pathWithoutExtension
end getPathWithoutExtension
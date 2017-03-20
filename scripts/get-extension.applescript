on getExtension(fname)
	set fextension to ""
	# save original delimiters
	set defaultTID to AppleScript's text item delimiters
	try
		# debug
		#set fname to "/Users/yourname/temp/some.log"
		# set new delimiters to "."
		set AppleScript's text item delimiters to {"."}
		# based on new delimiters it's easy to find the extension
		set fextension to last text item of fname
		# return original delimiters back
		set AppleScript's text item delimiters to defaultTID
	on error
		# just in case, return original delimiters back on error
		set AppleScript's text item delimiters to defaultTID
	end try
	return fextension
end getExtension
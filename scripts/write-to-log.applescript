on write2log(logName, msg2log)
	set msg to ("[" & (time string of (current date)) & "]") & " " & msg2log
	do shell script "echo " & msg & " >> " & logName & ""
end write2log
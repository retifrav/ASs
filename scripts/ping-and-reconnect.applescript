repeat
	
	try
		do shell script "ping -o -t2 ya.ru"
		--log "OK"
	on error
		log "[" & time string of (current date) & "] disconnected... AGAIN"
		do shell script "networksetup -setairportpower en0 off"
		do shell script "networksetup -setairportpower en0 on"
	end try
	
	delay 5
	
end repeat
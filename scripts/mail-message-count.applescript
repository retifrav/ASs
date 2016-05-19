(*

    The script shows [unread] message count for each mailbox in all accounts. The information is displayed in the log.

 *)

# working with Mail.app
tell application "Mail"
    
    set everyAccount to every account
    repeat with eachAccount in everyAccount
        set accountMailboxes to every mailbox of eachAccount
        repeat with eachMailBox in accountMailboxes
            
            # count all messages
            set messageCount to (count of (messages of eachMailBox))
            
            # count only unread messages
            #set messageCount to (count of (messages of eachMailBox whose read status is false))
            
            # count only flagged messages
            #set messageCount to (count of (messages of eachMailBox whose flagged status is true))
            
            # show only not empty mailboxes
            if messageCount > 0 then
                log name of eachAccount & " | " & name of eachMailBox & " | " & messageCount
            end if
            
        end repeat
    end repeat
    
end tell
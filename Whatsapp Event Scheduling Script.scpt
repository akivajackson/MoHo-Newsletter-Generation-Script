-- Define the list of tuples (message, send_date)
-- set messageList to {{"Message 1", "2024-07-28T12:32"}, {"Message 2", "2024-07-29T14:00"}}
-- set messageList to text returned of (display dialog "Enter data in the format 'Event Name, Start Date, Start Time, End Date, End Time, Location, Details'" default answer "")
set messageList to {{"message", "time"}}






















on runJavaScript(jsCode)
	tell application "Google Chrome"
		activate
		tell the active tab of window 1
			delay 0.3
			execute javascript jsCode
		end tell
	end tell
end runJavaScript

on pasteText(text)
	tell application "System Events"
		keystroke "a" using {command down}
		set the clipboard to inputText
		delay 0.2 -- Give the system a moment to set the clipboard
		keystroke "v" using command down
		delay 0.1
	end tell
end pasteText

-- Iterate over each tuple in the message list
repeat with messageTuple in messageList
	set messageText to item 1 of messageTuple
	set sendDate to item 2 of messageTuple
	
	-- Insert the message into the message input div
	set jsCode to "document.querySelector('div.mx_BasicMessageComposer_input div').focus();"
	runJavaScript(jsCode)
	pasteText(messageText)
	
	-- Click the schedule button
	set jsCode to "document.querySelector('div[aria-label=\"Scheduled Messages\"]').click();"
	runJavaScript(jsCode)
	
	-- Set the schedule time input
	set jsCode to "document.querySelector('input[placeholder=\"ex. tomorrow morning\"]').focus();"
	runJavaScript(jsCode)
	pasteText(sendDate)
	
	delay 0.2
	
	-- Click the submit button to schedule the message
	set jsCode to "
        // JavaScript code to click the button with the specified text
        function clickButtonWithText(buttonText) {
            var buttons = document.querySelectorAll('div[role=\"button\"]');
            for (var i = 0; i < buttons.length; i++) {
                var span = buttons[i].querySelector('span.bp_Button2_text');
                if (span && span.textContent.trim() === buttonText) {
                    buttons[i].click();
                    break;
                }
            }
        }
        
        // Call the function with the desired button text
        clickButtonWithText('Scheduled Send');
     "
	runJavaScript(jsCode)
	
	-- Wait a bit before scheduling the next message
	delay 10
end repeat
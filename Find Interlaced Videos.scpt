tell application "Finder" to set folderRoot to (choose folder with prompt "Please select directory.")



on returnNumbersInString(inputString)
	set s to quoted form of inputString
	do shell script "sed s/[a-zA-Z\\']//g <<< " & s's quoted form
	set dx to the result
	set numlist to {}
	repeat with i from 1 to count of words in dx
		set this_item to word i of dx
		try
			set this_item to this_item as number
			set the end of numlist to this_item
		end try
	end repeat
	return numlist
end returnNumbersInString



on gimmieFilesInSubfolders(inputFolder)
	tell application "Finder" to get every file in the entire contents of (inputFolder) as alias list
end gimmieFilesInSubfolders

set filePile to gimmieFilesInSubfolders(folderRoot)

repeat with theFile in filePile
	--do shell script "echo " & theFile & " >>~/Desktop/test.txt"
	try
		
		set this_posix_item to (the POSIX path of (theFile))
		log this_posix_item
		
		
		tell application "System Events"
			--set path_only to POSIX path of ((container of theFile) as text)
			
			
			--		set path_only to characters 1 thru -((offset of "/" in (reverse of items of this_posix_item as string)) + 1) of this_posix_item as string
			--		log path_only
		end tell
		
		set filename_only to do shell script "basename " & quoted form of this_posix_item
		--	do shell script ("cd " & quoted form of path_only)
		--	delay 1
		
		
		set output to do shell script ("/usr/local/bin/ffmpeg -y -i " & quoted form of this_posix_item & " -map 0:v:0 -filter:v idet -frames:v 500 -an -f rawvideo /dev/null 2>&1")
		
		set text item delimiters to {"Multi frame detection:"}
		set trimmedNums to text items 2 thru 2 of output as string
		log trimmedNums
		--		set output to do shell script ("ls")
		
		--do shell script "echo " & output & " >>~/Desktop/test.txt"
		
		
		set justNums to returnNumbersInString(trimmedNums)
		--log justNums
		
		set tffValue to the first item of justNums
		--log tffValue
		set bffValue to the second item of justNums
		--log bffValue
		set progValue to the (third item of justNums) + 5 --Margin of error for text files
		--log progValue
		
		set isVideoInterlaced to false
		if progValue is less than tffValue then
			set isVideoInterlaced to true
			log isVideoInterlaced
			do shell script "echo TFF: " & this_posix_item & " >>~/Desktop/Interlaced.txt"
			log "TFF"
		else if progValue is less than bffValue then
			set isVideoInterlaced to true
			log isVideoInterlaced
			do shell script "echo BFF: " & this_posix_item & " >>~/Desktop/Interlaced.txt"
			log "BFF"
		end if
		
	end try
end repeat

display dialog "Done scanning this folder and subfolders for interlaced files. Check Interlaced.txt on the desktop for the full list."
--beep
--log "Done scanning this folder and subfolders for interlaced files"

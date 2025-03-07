currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
results=$(cat /Users/"$currentUser"/Library/Application\ Support/Google/Chrome/Local\ State | grep -o '[[:alnum:]+\.\_\-]*@gmail.com]*'| uniq -i)
echo "<result>"$results"</result>"
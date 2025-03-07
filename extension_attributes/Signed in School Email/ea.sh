currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
results=$(cat /Users/"$currentUser"/Library/Application\ Support/Google/Chrome/Local\ State | grep -o '[[:alnum:]+\.\_\-]*@nfv.k12.ia.us]*'| uniq -i)
echo "<result>"$results"</result>"
currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
account=$(sudo -u "$currentUser" defaults read MobileMeAccounts Accounts | grep AccountID | cut -d \" -f2)

if [[ -z "${account// }" ]]
then
    echo "<result>Not Signed In</result>"
else
    echo "<result>"$account"</result>"
fi
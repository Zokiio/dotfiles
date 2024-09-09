
# This script is used to add a reference to a ticket in the commit message.
# It takes a file path as an argument and reads the content of the file.
# It then extracts the current branch number using `git branch --show-current` command.
# If the branch number is not found, the script exits.
# The script also extracts the team name from the parent directory of the git repository.
# If the team name is not found, the script exits.
# The ticket number is constructed by combining the team name and the branch number.
# If the commit message already contains a reference to the ticket, the script exits.
# Finally, the script appends the ticket reference to the commit message and writes it back to the file.
#!/bin/bash
FILE=$1
MSG=$(cat $FILE)

NUMBER=$(git branch --show-current | grep -E -i -o '^[0-9]+')
[[ -z $NUMBER ]] && exit 0

TEAM=$(basename $(dirname $(git rev-parse --show-toplevel)) | tr '[:lower:]' '[:upper:]')
[[ -z $TEAM ]] && exit 0

TICKET="$TEAM-$NUMBER"
[[ $MSG == *"ref: $TICKET"* ]] && exit 0

echo -en "$MSG\n\nref: $TICKET" > $FILE
#!/bin/sh

GIT=`which git`
REPO_DIR=$PWD
cd ${REPO_DIR}
if [ ! -z $LAST_COMMIT ]; then
    read -p "I found that you made this commit earlier: "$LAST_COMMIT"\n\n Would you like to reuse it ? (y/n)"
    if [ "$answer" != "${answer#[Yy]}" ] ;then
	eval $LAST_COMMIT
	exit 0
    else
	JIRA_BRANCH_IDENTIFIER=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
	echo $JIRA_BRANCH_IDENTIFIER
	read -p "Was it long ? Like how long ? (Format is 'h' for hour and 'm' for minutes): " TIME
	echo ${TIME}
	read -p "That much ?? What did you do all this time (commit message): " MESSAGE
	echo ${MESSAGE}
	FORMATTED_MESSAGE=$JIRA_BRANCH_IDENTIFIER" #time "$TIME" #comment "$MESSAGE
	export LAST_COMMIT='$GIT commit -m "$FORMATTED_MESSAGE"'
	${GIT} commit -m "$FORMATTED_MESSAGE"
    fi
else
    JIRA_BRANCH_IDENTIFIER=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
    echo $JIRA_BRANCH_IDENTIFIER
    read -p "Was it long ? Like how long ? (Format is 'h' for hour and 'm' for minutes): " TIME
    echo ${TIME}
    read -p "That much ?? What did you do all this time (commit message): " MESSAGE
    echo ${MESSAGE}
    FORMATTED_MESSAGE=$JIRA_BRANCH_IDENTIFIER" #time "$TIME" #comment "$MESSAGE
    export LAST_COMMIT='$GIT commit -m "$FORMATTED_MESSAGE"'
    ${GIT} commit -m "$FORMATTED_MESSAGE"
fi

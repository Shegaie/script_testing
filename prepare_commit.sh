#!/bin/sh

GIT=`which git`
REPO_DIR=$PWD
cd ${REPO_DIR}

#Get jira branch identifier from your current branch
JIRA_BRANCH_IDENTIFIER=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo "Jira branch identifier will be :"$JIRA_BRANCH_IDENTIFIER"\n"

#Ask you the time you spent on this commit
LAST_TIME=$(sed '1q;d' /tmp/commit_params_history.txt);
read -p "Was it long ? Like how long ? (Format is 'h' for hour and 'm' for minutes) (default: "$LAST_TIME"): " TIME
echo ${TIME} > /tmp/commit_params_history.txt

#Ask what you did on this commit                                                                                                                                                                        
LAST_MESSAGE=$(sed '2q;d' /tmp/commit_params_history.txt);
read -p "That much ?? What did you do all this time (commit message) (default: "$LAST_MESSAGE"): " MESSAGE
echo ${MESSAGE} >> /tmp/commit_params_history.txt

#Build the command and fire it
FORMATTED_MESSAGE=$JIRA_BRANCH_IDENTIFIER" #time "$TIME" #comment "$MESSAGE
${GIT} commit -m "$FORMATTED_MESSAGE"

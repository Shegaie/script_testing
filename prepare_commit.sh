#!/bin/sh

GIT=`which git`
REPO_DIR=$PWD
cd ${REPO_DIR}
JIRA_BRANCH_IDENTIFIER=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo $JIRA_BRANCH_IDENTIFIER
read -p "Was it long ? Like how long ? (Format is 'h' for hour and 'm' for minutes): " TIME
echo ${TIME} > /tmp/commit_params_history.txt
read -p "That much ?? What did you do all this time (commit message): " MESSAGE
echo ${MESSAGE} >> /tmp/commit_params_history.txt
FORMATTED_MESSAGE=$JIRA_BRANCH_IDENTIFIER" #time "$TIME" #comment "$MESSAGE
${GIT} commit -m "$FORMATTED_MESSAGE"

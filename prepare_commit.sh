#!/bin/bash

BLUE='\033[1;34m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

GIT=`which git`
REPO_DIR=$PWD
cd ${REPO_DIR}

#Get jira branch identifier from your current branch
JIRA_BRANCH_IDENTIFIER=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo -e "\n${YELLOW}Jira branch identifier will be => ${RED}"$JIRA_BRANCH_IDENTIFIER

#Ask you the time you spent on this commit
LAST_TIME=$(sed '1q;d' /tmp/commit_params_history.txt);
echo -e "${BLUE}Was it long ? Like how long ? (Format is 'h' for hour and 'm' for minutes) ${GREEN}(default: "$LAST_TIME"): ${RED}\c"
read TIME
if test -z ${TIME}; then TIME=$LAST_TIME; else echo ${TIME} > /tmp/commit_params_history.txt; fi
echo -e "${YELLOW}Ok then time will be => ${RED}"$TIME

#Ask what you did on this commit
LAST_MESSAGE=$(sed '2q;d' /tmp/commit_params_history.txt);
echo -e "${BLUE}That much ?? What did you do all this time (commit message) ${GREEN}(default: "$LAST_MESSAGE"): ${RED}\c"
read MESSAGE
echo ${MESSAGE} >> /tmp/commit_params_history.txt

if test -z "$MESSAGE";
then MESSAGE=$LAST_MESSAGE;
else echo ${MESSAGE} >> /tmp/commit_params_history.txt;
fi

echo -e "${YELLOW}Ok then message will be => ${RED}"$MESSAGE

#Build the command, ask user, fire it
echo -e "${NC}"

FORMATTED_MESSAGE=$JIRA_BRANCH_IDENTIFIER" #time "$TIME" #comment "$MESSAGE

echo -e "${BLUE}Seems good to you ? \n => ${RED}"$GIT" commit -m '"$FORMATTED_MESSAGE"'${NC}"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) ${GIT} commit -m "'$FORMATTED_MESSAGE'"; break;;
        No ) exit;;
    esac
done



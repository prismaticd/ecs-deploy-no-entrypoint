#!/usr/bin/env bash

if [ -z ${SLACK_USER} ]; then
    SLACK_USER="Deploy Bot";
fi

if [ -z ${SLACK_CHANNEL} ]; then
    SLACK_CHANNEL="general";
fi

if [ -z ${COMMIT_USER} ]; then
    COMMIT_USER="${GITLAB_USER_LOGIN}";
fi

printf "*Deploy to test finished* \n v${RELEASE_ID}\n <https://gitlab.com/${CI_PROJECT_NAMESPACE}/${CI_PROJECT_PATH}/pipelines/${CI_PIPELINE_ID}|Pipeline link>  \n" | slacktee  -u "${SLACK_USER}" -p -a "good" -c "${SLACK_CHANNEL}";
printf "commit: ${CI_COMMIT_SHA} \n by ${COMMIT_USER} \n ${CI_COMMIT_MESSAGE}\n" | slacktee  -u "${SLACK_USER}" -c "${SLACK_CHANNEL}";

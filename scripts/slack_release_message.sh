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

if [ -z ${ENVIRONMENT_NAME} ]; then
    ENVIRONMENT_NAME="${CI_ENVIRONMENT_NAME}";
fi

printf "*Deploy to ${ENVIRONMENT_NAME} finished* \n by ${GITLAB_USER_NAME} \n v${RELEASE_ID}\n <${CI_PIPELINE_URL}|Pipeline link>  \n" | slacktee  -u "${SLACK_USER}" -p -a "good" -c "${SLACK_CHANNEL}";
printf "commit: ${CI_COMMIT_SHA} \n by ${COMMIT_USER} \n ${CI_COMMIT_MESSAGE}\n" | slacktee  -u "${SLACK_USER}" -c "${SLACK_CHANNEL}";

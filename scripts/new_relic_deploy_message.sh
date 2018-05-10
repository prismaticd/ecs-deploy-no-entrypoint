#!/usr/bin/env bash

if [ -z ${NR_APPLICATION_ID} ]; then
    echo "Missing NR_APPLICATION_ID env variable";
    exit 1;
fi
if [ -z ${NR_API_KEY} ]; then
    echo "Missing NR_API_KEY env variable";
    exit 1;
fi
if [ -z ${MSG_REVISION} ];  then
    export MSG_REVISION=$(echo "v${RELEASE_ID}");
fi
if [ -z ${MSG_DESCRIPTION} ];  then
    export MSG_DESCRIPTION=$(echo "${CI_COMMIT_SHA} pipeline https://gitlab.com/${CI_PROJECT_NAMESPACE}/${CI_PROJECT_PATH}/pipelines/${CI_PIPELINE_ID}");
fi
if [ -z ${MSG_USER} ];  then
    export MSG_USER=$(echo "${GITLAB_USER_LOGIN}");
fi
if [ -z ${MSG_CHANGELOG} ];  then
    export MSG_USER=$(echo "${CI_COMMIT_MESSAGE}");
fi

JSON_MESSAGE=$(jq -n '{
deployment: {
  revision: env.MSG_REVISION,
  description: env.MSG_DESCRIPTION,
  user: env.MSG_USER,
  changelog: env.MSG_CHANGELOG
}}')

curl -X POST "https://api.newrelic.com/v2/applications/${NR_APPLICATION_ID}/deployments.json" \
       -H "X-Api-Key:${NR_API_KEY}" -i \
       -H "Content-Type: application/json" \
       -d "${JSON_MESSAGE}"

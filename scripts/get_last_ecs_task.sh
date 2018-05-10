#!/usr/bin/env bash

ARG1="First argument should be aws region ex: us-west-2"
ARG2="Second argument should be the prefix of the task definition"

if [ -z $2 ]; then
  echo ARG1;
  echo ARG2;
  exit 1;
fi 

aws ecs list-task-definitions --region=$1 --sort DESC --status ACTIVE --family-prefix $2 --max-items 1 | jq -r '.taskDefinitionArns[0]'

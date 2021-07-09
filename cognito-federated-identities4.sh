#!/bin/bash
export AWS_REGION=ap-northeast-1
IDENTITY_POOL_ID=ap-northeast-1:1fcf78ad-dbab-46eb-b1b9-22e324f11719
IDENTITY_ID=$(aws cognito-identity get-id \
  --identity-pool-id ${IDENTITY_POOL_ID} \
  --query "IdentityId" \
  --output text ) && echo ${IDENTITY_ID}
OUTPUT=$(aws cognito-identity get-credentials-for-identity \
  --identity-id ${IDENTITY_ID}) && echo ${OUTPUT}
export AWS_ACCESS_KEY_ID=$(echo ${OUTPUT} | jq -r .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo ${OUTPUT} | jq -r .Credentials.SecretKey)
export AWS_SESSION_TOKEN=$(echo ${OUTPUT} | jq -r .Credentials.SessionToken)
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY
echo $AWS_SESSION_TOKEN
aws sts get-caller-identity
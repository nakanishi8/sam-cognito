#!/bin/bash
export AWS_REGION=ap-northeast-1
identity=ap-northeast-1:1fcf78ad-dbab-46eb-b1b9-22e324f11719
userpool=ap-northeast-1_Nx0nCM8zv
client=5v2qfiq3adsd8mpafcfv74ghvg
poolurl=cognito-idp.$AWS_REGION.amazonaws.com/$userpool
USER_EMAIL=nakanishi8@gmail.com
PASSWORD='aap55750'
id_token=$(aws cognito-idp admin-initiate-auth \
--auth-flow ADMIN_USER_PASSWORD_AUTH \
--auth-parameters USERNAME=nakanishi8@gmail.com,PASSWORD=aap55750 \
--user-pool-id $userpool \
--client-id $client \
--query "AuthenticationResult.IdToken" \
--output text)
identity_id=$(aws cognito-identity get-id \
  --identity-pool-id $identity \
  --logins "$poolurl=$id_token" \
  --query "IdentityId" \
  --output text)
echo $identity_id
credentials=$(aws cognito-identity get-credentials-for-identity \
  --identity-id $identity_id \
  --logins "$poolurl=$id_token")
export AWS_ACCESS_KEY_ID=$(echo ${credentials} | jq -r .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo ${credentials} | jq -r .Credentials.SecretKey)
export AWS_SESSION_TOKEN=$(echo ${credentials} | jq -r .Credentials.SessionToken)
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY
echo $AWS_SESSION_TOKEN
aws sts get-caller-identity
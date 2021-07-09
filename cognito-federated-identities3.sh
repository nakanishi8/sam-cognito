REGION=ap-northeast-1
USER_POOL_ID=ap-northeast-1_Nx0nCM8zv
CLIENT_ID=5v2qfiq3adsd8mpafcfv74ghvg
USER_EMAIL=nakanishi8@gmail.com
PASSWORD='aap55750'
IDENTITY_POOL_ID=ap-northeast-1:1fcf78ad-dbab-46eb-b1b9-22e324f11719
COGNITO_USER_POOL=cognito-idp.${REGION}.amazonaws.com/${USER_POOL_ID}
ID_TOKEN=$(aws cognito-idp admin-initiate-auth \
--user-pool-id ${USER_POOL_ID} \
--client-id ${CLIENT_ID} \
--auth-flow ADMIN_USER_PASSWORD_AUTH \
--auth-parameters "USERNAME=${USER_EMAIL},PASSWORD=${PASSWORD}" \
--query "AuthenticationResult.IdToken" \
--output text) && echo ${ID_TOKEN}
IDENTITY_ID=$(aws cognito-identity get-id \
--identity-pool-id ${IDENTITY_POOL_ID} \
--logins "${COGNITO_USER_POOL}=${ID_TOKEN}" \
--query "IdentityId" \
--output text) && echo ${IDENTITY_ID}
OUTPUT=$(aws cognito-identity get-credentials-for-identity \
--identity-id ${IDENTITY_ID} \
--logins "${COGNITO_USER_POOL}=${ID_TOKEN}") && echo ${OUTPUT}
AWS_ACCESS_KEY_ID=$(echo ${OUTPUT} | jq .Credentials.AccessKeyId)
AWS_SECRET_ACCESS_KEY=$(echo ${OUTPUT} | jq .Credentials.SecretKey)
AWS_SESSION_TOKEN=$(echo ${OUTPUT} | jq .Credentials.SessionToken)
echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN"
aws sts get-caller-identity

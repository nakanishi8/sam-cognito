REGION=ap-northeast-1
USER_POOL_ID=ap-northeast-1_3xLmrs4Qs
CLIENT_ID=6jkbe0dh6r5pa875he0c94m5n0
USER_EMAIL=shinji.nakanishi@lab.sompo.io
PASSWORD='Passw0rd!!'
IDENTITY_POOL_ID=ap-northeast-1:8713def7-21a9-4693-97b6-4681b0ec8c11
COGNITO_USER_POOL=cognito-idp.${REGION}.amazonaws.com/${USER_POOL_ID}
ID_TOKEN=$(aws cognito-idp admin-initiate-auth \
--user-pool-id ${USER_POOL_ID} \
--client-id ${CLIENT_ID} \
--auth-flow ADMIN_NO_SRP_AUTH \
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
aws sts get-caller-identity

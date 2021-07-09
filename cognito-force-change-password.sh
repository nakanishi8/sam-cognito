REGION=ap-northeast-1
USER_POOL_ID=ap-northeast-1_DPAiNCc9l
CLIENT_ID=6hb0vs37l261f7qvrsl9ti7v2r
NAME=shinji.nakanishi
USER_EMAIL=shinji.nakanishi@lab.sompo.io
PASSWORD='Passw0rd!'
NEW_PASSWORD='Passw0rd!!'
ADMIN_INITIATE_AUTH=$(aws cognito-idp admin-initiate-auth \
--user-pool-id ${USER_POOL_ID} \
--client-id ${CLIENT_ID} \
--auth-flow ADMIN_NO_SRP_AUTH \
--auth-parameters "name=${NAME},USERNAME=${USER_EMAIL},USEREMAIL=${USER_EMAIL},PASSWORD=${PASSWORD}")
SESSION=$(jq -r '.Session' <<< "${ADMIN_INITIATE_AUTH}")
aws cognito-idp admin-respond-to-auth-challenge \
--user-pool-id ${USER_POOL_ID} \
--client-id ${CLIENT_ID} \
--challenge-name NEW_PASSWORD_REQUIRED \
--challenge-responses NEW_PASSWORD=${NEW_PASSWORD},name=${NAME},USERNAME=${USER_EMAIL},USEREMAIL=${USER_EMAIL} \
--session ${SESSION}

#aws cognito-idp admin-initiate-auth \
#--user-pool-id ap-northeast-1_DPAiNCc9l \
#--client-id 6hb0vs37l261f7qvrsl9ti7v2r \
#--auth-flow ADMIN_NO_SRP_AUTH \
#--auth-parameters \
#USERNAME=shinji.nakanishi@lab.sompo.io,PASSWORD=Passw0rd!
#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `set_aws_creds hicham` to set credentials from hicham env.

function set_aws_creds -a ACCOUNT -d "Sets AWS credential environment variables based on the account passed to the function." 
    set -x OP_ITEM "AWS - Root (Personal)"
    
    switch $ACCOUNT
    case 'hicham'
        set -x OP_ITEM "AWS - Hicham Account"
    case 'lightspeed'
        set -x OP_ITEM "AWS - Lightspeed Account"
    end

    set -x AWS_CREDS (aws sts get-session-token --profile (op item get $OP_ITEM --field "Profile") --serial-number (op item get $OP_ITEM --field "MFA ARN") --token (op item get $OP_ITEM --otp) | string collect)

    if test $status = 0
        set -Ux AWS_ACCESS_KEY_ID (echo $AWS_CREDS | jq -r .Credentials.AccessKeyId)
        set -Ux AWS_SECRET_ACCESS_KEY (echo $AWS_CREDS | jq -r .Credentials.SecretAccessKey)
        set -Ux AWS_SESSION_TOKEN (echo $AWS_CREDS | jq -r .Credentials.SessionToken)

        echo "🟢 All items are set for access key: $AWS_ACCESS_KEY_ID"
    else
        echo "🔴 Setting credentials failed"
    end
end

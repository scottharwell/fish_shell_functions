#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `aws_hicham` functions will be available from your shell.

function aws_hicham
    set -gx AWS_CREDS (aws sts get-session-token --profile (op item get "AWS - Hicham Account" --field "Profile") --serial-number (op item get "AWS - Hicham Account" --field "MFA ARN") --token (op item get "AWS - Hicham Account" --otp) | string collect)

    set -Ux AWS_ACCESS_KEY_ID (echo $AWS_CREDS | jq -r .Credentials.AccessKeyId)
    set -Ux AWS_SECRET_ACCESS_KEY (echo $AWS_CREDS | jq -r .Credentials.SecretAccessKey)
    set -Ux AWS_SESSION_TOKEN (echo $AWS_CREDS | jq -r .Credentials.SessionToken)

    echo "🟢 All items are set for access key: $AWS_ACCESS_KEY_ID"
end

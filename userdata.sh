#!/bin/bash -x
# The bucket containing the userdata.d
export USERDATAD_BUCKET=userdata.example.com
# Required to set the endpoint of the aws-cli
export AWS_DEFAULT_REGION=eu-west-1
# Install Prerequisites
yum install -y aws-cli
# Download all .sh scripts from the bucket and pipe to bash
SCRIPTS=$(aws s3 ls s3://$USERDATAD_BUCKET/userdata.d/ | awk '{ print  $4 }')
for S in $SCRIPTS; do
  aws --color=off s3 cp --quiet s3://$USERDATAD_BUCKET/userdata.d/$S - | bash -s
done
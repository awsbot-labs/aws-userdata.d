# aws-userdata.d
A set of bash scripts and mechanism to download them for bootstrapping AWS instances.

## Getting started
This is a very simple mechanism that allows an EC2 instance to download a set of scripts from an S3 bucket, and run those scripts launch. hence boot strapping the instance with predefined packages config files etc.

## How it works?
An S3 bucket in Amazon hosts the scripts which are available to download from Authentcated users in the Amazon account. Alternatively you could make the bucket public, but make sure the scripts are sanitized.

The mechanism to download and piep to bash is:
```
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
```
#!/bin/bash
SECRET_KEY="<ENTER YOUR SECRET KEY>"
ACCESS_KEY="<ENTER YOUR ACCESS KEY>"
PATH_CREDS="<ENTER YOUR PATH TO .aws\credentials>"
BUCKET_NAME_DEPLOY="buildlog8415"
BUCKET_NAME_ARTEFACT="artefactslog8415"
KEY_PAIR_NAME="<ENTER YOUR KEY PAIR NAME>"
SECURITY_GROUP="<ENTER YOUR SECURITY GROUP>"


#SETUP credentials to use aws cli
# printf "[default]
# aws_access_key_id=$ACCESS_KEY
# aws_secret_access_key=$SECRET_KEY
# " > $PATH_CREDS

#Create and configure S3 buckets
aws s3api create-bucket --bucket $BUCKET_NAME_DEPLOY
aws s3api create-bucket --bucket $BUCKET_NAME_ARTEFACT
aws s3api put-bucket-policy --bucket $BUCKET_NAME_DEPLOY --policy file://policy_deploy.json
aws s3api put-bucket-policy --bucket $BUCKET_NAME_ARTEFACT --policy file://policy_artefact.json

#Create new role to access S3
ROLE_NAME="s3-access"
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://policy_s3_ec2_trust.json
aws iam put-role-policy --role-name $ROLE_NAME --policy-name AmazonS3FullAccess --policy-document file://policy_s3_access.json
aws iam create-instance-profile --instance-profile-name $ROLE_NAME-profile
aws iam add-role-to-instance-profile --instance-profile-name $ROLE_NAME-profile --role-name $ROLE_NAME

#Create ubuntu 20.04 EC2 instance
aws ec2 run-instances --image-id ami-04505e74c0741db8d --iam-instance-profile Name=$ROLE_NAME-profile  --count 1 --instance-type t2.micro --key-name $KEY_PAIR_NAME --security-group-ids $SECURITY_GROUP --user-data file://ec2_setup.txt


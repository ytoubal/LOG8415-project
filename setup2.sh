#!/bin/bash
TOPIC_NAME="s3-topic"
TOPIC_ARN=$(aws sns create-topic --name $TOPIC_NAME | py -c "import sys, json; print(json.load(sys.stdin)['TopicArn'])")
END_POINT="<ENTER THE PUBLIC DNS OF THE EC2 INSTANCE>"
echo $TOPIC_ARN
aws sns subscribe --topic-arn $TOPIC_ARN --protocol http --notification-endpoint $END_POINT


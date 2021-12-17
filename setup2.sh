#!/bin/bash
TOPIC_NAME="s3-topic"
TOPIC_ARN=$(aws sns create-topic --name $TOPIC_NAME | py -c "import sys, json; print(json.load(sys.stdin)['TopicArn'])")
END_POINT="<ENTER YOUR END POINT URL>"
echo $TOPIC_ARN
aws sns subscribe --topic-arn $TOPIC_ARN --protocol http --notification-endpoint $END_POINT


#!/bin/bash

STACKID=`aws cloudformation create-stack --stack-name Spotinst --region us-east-1 --capabilities CAPABILITY_IAM  --template-body file://spotinst-cloudformation.json --parameters ParameterKey=ExternalID,ParameterValue=AAABBBCCCDDDAAABBBCCCDDD --query 'StackId' --output text`

printf "StackID is: %s\n" "$STACKID" 
printf "Checking Stack creation.....  \n"
StackResponse=`aws cloudformation describe-stacks --stack-name $STACKID --region us-east-1  --query 'Stacks[0].[StackStatus,Outputs[0].OutputValue]' --output text`
StackResponseArr=( $StackResponse )
StackStatus=${StackResponseArr[0]}
while [ "$StackStatus" == "CREATE_IN_PROGRESS" ]
do
  printf "%s\n" "$StackStatus"
  sleep 3s
  StackResponse=`aws cloudformation describe-stacks --stack-name $STACKID --region us-east-1  --query 'Stacks[0].[StackStatus,Outputs[0].OutputValue]' --output text`
  StackResponseArr=( $StackResponse )
  StackStatus=${StackResponseArr[0]}
done

StackOutput=${StackResponseArr[1]}
printf "%s - Role ARN is: %s\n" "$StackStatus" "$StackOutput" 

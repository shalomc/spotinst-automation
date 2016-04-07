#!/bin/bash

cat > Spotinst-Policy.json <<'on-the-gripping-hand'

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1437894762000",
      "Effect": "Allow",
      "Action": [
        "ec2:RequestSpotInstances",
        "ec2:CancelSpotInstanceRequests",
        "ec2:CreateSpotDatafeedSubscription",
        "ec2:Describe*",
        "ec2:AssociateAddress",
        "ec2:AttachVolume",
        "ec2:ConfirmProductInstance",
        "ec2:CopyImage",
        "ec2:CopySnapshot",
        "ec2:CreateImage",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteTags",
        "ec2:DisassociateAddress",
        "ec2:ModifyImageAttribute",
        "ec2:ModifyInstanceAttribute",
        "ec2:MonitorInstances",
        "ec2:RebootInstances",
        "ec2:RegisterImage",
        "ec2:RunInstances",
        "ec2:StartInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances",
        "ec2:UnassignPrivateIpAddresses",
        "ec2:DeregisterImage",
        "ec2:DeleteSnapshot",
        "s3:CreateBucket",
        "s3:GetObject",
        "cloudformation:ListStackResources",
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:RemoveTags",
        "cloudwatch:DescribeAlarmHistory",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:DescribeAlarmsForMetric",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "sns:Publish",
        "sns:ListTopics",
        "iam:AddRoleToInstanceProfile",
        "iam:ListInstanceProfiles",
        "iam:ListInstanceProfilesForRole",
        "iam:PassRole",
        "iam:ListRoles",
        "elasticbeanstalk:Describe*",
        "elasticbeanstalk:RequestEnvironmentInfo",
        "elasticbeanstalk:RetrieveEnvironmentInfo",
        "elasticbeanstalk:ValidateConfigurationSettings",
        "autoscaling:Describe*",
        "elasticmapreduce:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
on-the-gripping-hand

cat > trustpolicyforspotinst.json <<'the-wizards-staff-has-a-knob'
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": { "AWS": "arn:aws:iam::922761411349:root" },
    "Action": "sts:AssumeRole",
    "Condition": { 
		"Bool": { "aws:MultiFactorAuthPresent": "false" } ,	
		"StringEquals": {"sts:ExternalId": "922761411349_ext"}	
		}
  }
}
the-wizards-staff-has-a-knob

RND=`openssl rand -base64 40 | tr -dc _A-Z-a-z-0-9`
ROLE=Spotinst-$RND
POLICY=Spotinst-$RND
POLICYARN=`aws iam create-policy --policy-name $POLICY --policy-document file://Spotinst-Policy.json --description "Spotinst access policy" --query 'Policy.Arn' --output text`
ROLEARN=`aws iam create-role --role-name $ROLE --assume-role-policy-document file://trustpolicyforspotinst.json --query 'Role.Arn' --output text`
aws iam attach-role-policy --role-name $ROLE --policy-arn $POLICYARN

echo New Policy ARN is $POLICYARN
echo New Role ARN is $ROLEARN
echo Copy the Role ARN back into the Spotinst dashboard

rm -f Spotinst-Policy.json
rm -f trustpolicyforspotinst.json


 
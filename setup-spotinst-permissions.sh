cat > Spotinst-Policy.json <<'on-the-gripping-hand'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1437894762000",
      "Effect": "Allow",
      "Action": [
        "ec2:AllocateAddress",
        "ec2:AssignPrivateIpAddresses",
        "ec2:AssociateAddress",
        "ec2:AttachVolume",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CancelReservedInstancesListing",
        "ec2:CancelSpotInstanceRequests",
        "ec2:ConfirmProductInstance",
        "ec2:CopyImage",
        "ec2:CopySnapshot",
        "ec2:CreateImage",
        "ec2:CreateNetworkInterface",
        "ec2:CreatePlacementGroup",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSnapshot",
        "ec2:CreateSpotDatafeedSubscription",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAddresses",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeImageAttribute",
        "ec2:DescribeImages",
        "ec2:DescribeImportImageTasks",
        "ec2:DescribeImportImageTasks",
        "ec2:DescribeImportSnapshotTasks",
        "ec2:DescribeImportSnapshotTasks",
        "ec2:DescribeInstanceAttribute",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeInstances",
        "ec2:DescribeKeyPairs",
        "ec2:DescribeNetworkInterfaceAttribute",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribePlacementGroups",
        "ec2:DescribePrefixLists",
        "ec2:DescribeRegions",
        "ec2:DescribeReservedInstances",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSnapshotAttribute",
        "ec2:DescribeSnapshots",
        "ec2:DescribeSpotDatafeedSubscription",
        "ec2:DescribeSpotInstanceRequests",
        "ec2:DescribeSpotPriceHistory",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVolumeAttribute",
        "ec2:DescribeVolumeStatus",
        "ec2:DescribeVolumes",
        "ec2:DescribeVpcAttribute",
        "ec2:DescribeVpcClassicLink",
        "ec2:DescribeVpcEndpointServices",
        "ec2:DescribeVpcs",
        "ec2:DetachNetworkInterface",
        "ec2:DetachVolume",
        "ec2:DisassociateAddress",
        "ec2:EnableVolumeIO",
        "ec2:ModifyImageAttribute",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:MonitorInstances",
        "ec2:RebootInstances",
        "ec2:RegisterImage",
        "ec2:RequestSpotInstances",
        "ec2:RunInstances",
        "ec2:StartInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances",
        "ec2:UnassignPrivateIpAddresses",
        "ec2:DeregisterImage",
        "ec2:DeleteSnapshot"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "Stmt1437895027000",
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:DescribeInstanceHealth",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancerPolicyTypes",
        "elasticloadbalancing:DescribeLoadBalancerPolicies",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:RemoveTags",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "Stmt1437895081000",
      "Effect": "Allow",
      "Action": [
        "cloudwatch:DescribeAlarmHistory",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:DescribeAlarmsForMetric",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:PutMetricData"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "Stmt1441527617000",
      "Effect": "Allow",
      "Action": [
        "sns:Publish",
        "sns:ListTopics"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "Stmt1441527635000",
      "Effect": "Allow",
      "Action": [
        "iam:AddRoleToInstanceProfile",
        "iam:ListInstanceProfiles",
        "iam:ListInstanceProfilesForRole",
        "iam:PassRole",
        "iam:ListRoles"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "Stmt1441527705000",
      "Effect": "Allow",
      "Action": [
        "elasticmapreduce:*"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "Stmt1441527605000",
      "Effect": "Allow",
      "Action": [
        "elasticbeanstalk:*"
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

ROLE=Spotinst-Role-v9
POLICY=Spotinst-Policy-v9

POLICYARN=`aws iam create-policy --policy-name $POLICY --policy-document file://Spotinst-Policy.json --description "Spotinst access policy" --query 'Policy.Arn' --output text`
ROLEARN=`aws iam create-role --role-name $ROLE --assume-role-policy-document file://trustpolicyforspotinst.json --query 'Role.Arn' --output text`
aws iam attach-role-policy --role-name $ROLE --policy-arn $POLICYARN

echo New Policy ARN is $POLICYARN
echo New Role ARN is $ROLEARN
echo Copy the Role ARN back into the Spotinst dashboard

rm -f Spotinst-Policy.json
rm -f trustpolicyforspotinst.json

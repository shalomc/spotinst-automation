# Spotinst automation

A set of scripts and tools related to the awesome Spotinst service. 

## About
Spotinst is a service that let's you run production EC2 and Google compute loads on extremely cheap spot instances, saving 70% - 90% of operating costs, and having a scalable, robust and highly available environment.

To use spotinst, you must create an IAM policy and role. While the manual process is described in the Spotinst setup page, it is manual therefore error prone. The following scripts will automate this process for you. 

http://www.spotinst.com/

## Contents
* setup-spotinst-permissions.sh - A script to create the necessary IAM policy and role to allow Spotinst do it's magic
* spotinst-cloudformation.json - A CloudFormation template to create an IAM stack for Spotinst.
* spotinst-cloudformation.sh - A script that uses CloudFormation to create the necessary IAM policy and role to allow Spotinst do it's magic 

## Usage
* Run setup-spotinst-permissions.sh to create the relevant IAM policy and role. The script outputs the IAM role that must be pasted back into the spotinst setup page.  
* Run spotinst-cloudformation.sh to create the same as a CloudFormation stack. The script outputs the IAM role that must be pasted back into the spotinst setup page.  

## Prerequisites
* The aws cli tool should be installed and set up. http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html

## License
Copyright 2016 Shalom Carmel

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
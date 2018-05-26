#!/bin/bash

# [Description:]
#   Add Tag to Default VPC.

#config
AWS_PROFILE_NAME=cp24
echo $AWS_PROFILE_NAME

AWS_DEFVPC_PREFIX=Def
echo $AWS_DEFVPC_PREFIX

AWS_DEFVPC_REGION=ap-northeast-1
echo $AWS_DEFVPC_REGION

#ALIAS
AWS_DEFVPC_CMD_PRM='--region '${AWS_DEFVPC_REGION}' --profile '${AWS_PROFILE_NAME}
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  echo $AWS_DEFVPC_CMD_PRM
fi

#Dhcp
AWS_DEFVPC_CMD_RLT=`aws ec2 describe-dhcp-options $AWS_DEFVPC_CMD_PRM | jq -r '.DhcpOptions[].DhcpOptionsId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Dopt"
fi

#VPC
AWS_DEFVPC_CMD_RLT_VPC=`aws ec2 describe-vpcs $AWS_DEFVPC_CMD_PRM | jq -r '.Vpcs[] | select(.IsDefault == true) | .VpcId'`
echo $AWS_DEFVPC_CMD_RLT_VPC
if [ -n $AWS_DEFVPC_CMD_RLT_VPC ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT_VPC --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Vpc"
fi

#IGW
AWS_DEFVPC_CMD_RLT=`aws ec2 describe-internet-gateways $AWS_DEFVPC_CMD_PRM | jq -r '.InternetGateways[] | select(.Attachments[].VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" ) | .InternetGatewayId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Igw"
fi

#RTB
AWS_DEFVPC_CMD_RLT=`aws ec2 describe-route-tables $AWS_DEFVPC_CMD_PRM | jq -r '.RouteTables[] | select(.VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" ) | .RouteTableId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Rtb"
fi

#SG
AWS_DEFVPC_CMD_RLT=`aws ec2 describe-security-groups $AWS_DEFVPC_CMD_PRM | jq -r '.SecurityGroups[] | select(.VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" ) | .GroupId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Sg"
fi

#Subnet
AWS_DEFVPC_CMD_RLT=`aws ec2 describe-subnets $AWS_DEFVPC_CMD_PRM | jq -r '.Subnets[] | select(.VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" and .AvailabilityZone == "'${AWS_DEFVPC_REGION}a'") | .SubnetId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Subnet-a"
fi

AWS_DEFVPC_CMD_RLT=`aws ec2 describe-subnets $AWS_DEFVPC_CMD_PRM | jq -r '.Subnets[] | select(.VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" and .AvailabilityZone == "'${AWS_DEFVPC_REGION}b'") | .SubnetId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Subnet-b"
fi

AWS_DEFVPC_CMD_RLT=`aws ec2 describe-subnets $AWS_DEFVPC_CMD_PRM | jq -r '.Subnets[] | select(.VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" and .AvailabilityZone == "'${AWS_DEFVPC_REGION}c'") | .SubnetId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Subnet-c"
fi

AWS_DEFVPC_CMD_RLT=`aws ec2 describe-subnets $AWS_DEFVPC_CMD_PRM | jq -r '.Subnets[] | select(.VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" and .AvailabilityZone == "'${AWS_DEFVPC_REGION}d'") | .SubnetId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Subnet-d"
fi

#ACL
AWS_DEFVPC_CMD_RLT=`aws ec2 describe-network-acls $AWS_DEFVPC_CMD_PRM | jq -r '.NetworkAcls[] | select(.VpcId =="'${AWS_DEFVPC_CMD_RLT_VPC}'" ) | .NetworkAclId'`
echo $AWS_DEFVPC_CMD_RLT
if [ -n $AWS_DEFVPC_CMD_RLT ]; then
  aws ec2 create-tags $AWS_DEFVPC_CMD_PRM --resources $AWS_DEFVPC_CMD_RLT --tags "Key=Name,Value=${AWS_DEFVPC_PREFIX}-Acl"
fi

exit 0

---
layout: post
title: 'Learning AWS' 
author: haeyeon.hwang
tags: [aws]
image: /assets/img/blog/aws.png
hide_image: true
---

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## AWS cli

~~~bash
$ sudo apt get awscli
// make key-id and secret from KMS 

$ aws configure
AWS Access Key ID [****************BG6G]:

$ aws
usage: aws [options] <command> <subcommand> [<subcommand> ...] [parameters]
To see help text, you can run:

  aws help
  aws <command> help
  aws <command> <subcommand> help
aws: error: the following arguments are required: command

$ sudo apt install groff

$ cat ~/.aws/credentials
$ cat ~/.aws/config
~~~

## AWS S3

~~~bash
 $ aws s3api create-bucket --bucket my-popup-bucket --region ap-northeast-2 --create-bucket-configuration LocationConstraint=ap-northeast-2
{
    "Location": "http://my-popup-bucket.s3.amazonaws.com/"
}
$ aws s3 ls
2019-06-19 11:32:48 my-popup-bucket

$ sudo apt install fuse
$ cd /tmp
$ sudo wget -c https://dl.google.com/go/go1.9.2.linux-amd64.tar.gz -O - | tar -xz
$ sudo mv go /usr/local
$ mkdir repos
$ vi ~/.profile
PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
GOPATH=$HOME/repos
PATH=$PATH:$GOPATH/bin
$ . ~/.profile

$ go version
go version go1.9.2 linux/amd64
$ go get github.com/kahing/goofys
$ go install github.com/kahing/goofys
$ mkdir -p s3
$ aws s3 ls
2019-06-19 11:32:48 my-popup-bucket
$ goofys my-popup-bucket s3
$ cd s3
$ touch a
$ aws s3 ls my-popup-bucket
2019-06-19 12:23:32          0 a
~~~

~~~bash
$ github.com/aws/aws-sdk-go
$ aws s3 presign s3://my-popup-bucket/hello.html
https://s3.ap-northeast-2.amazonaws.com/my-popup-bucket/hello.html?X-Amz-Date=20190619T041119Z&X-Amz-SignedHeaders=host&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Expires=3600&X-Amz-Credential=AKIASRDSZDL22QYVBG6G%2F20190619%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=7d089fa71cdf19310effec04b2e6778370d2d974b4184ff790490f6c0cceafcf
~~~

## VPC

~~~bash
$ aws ec2 create-vpc --cidr-block 10.0.0.0/16
{
    "Vpc": {
        "DhcpOptionsId": "dopt-9a4995f1",
        "VpcId": "vpc-0f52836626e78f609",
        "InstanceTenancy": "default",
        "CidrBlock": "10.0.0.0/16",
        "State": "pending",
        "IsDefault": false,
        "Tags": []
    }
}
$ aws ec2 create-subnet --vpc-id vpc-0f52836626e78f609 --cidr-block 10.0.1.0/24
{
    "Subnet": {
        "State": "pending",
        "VpcId": "vpc-0f52836626e78f609",
        "AvailabilityZone": "ap-northeast-2c",
        "SubnetId": "subnet-0cb1166c2a9de0d89",
        "CidrBlock": "10.0.1.0/24",
        "AvailableIpAddressCount": 251
    }
}
$ aws ec2 create-subnet --vpc-id vpc-0f52836626e78f609 --cidr-block 10.0.0.0/24
{
    "Subnet": {
        "VpcId": "vpc-0f52836626e78f609",
        "AvailableIpAddressCount": 251,
        "SubnetId": "subnet-066640bf3ca33b1e9",
        "State": "pending",
        "CidrBlock": "10.0.0.0/24",
        "AvailabilityZone": "ap-northeast-2c"
    }
}
$ aws ec2 create-internet-gateway
{
    "InternetGateway": {
        "InternetGatewayId": "igw-06c2d483e1c908eee",
        "Tags": [],
        "Attachments": []
    }
}
$ aws ec2 attach-internet-gateway --vpc-id vpc-0f52836626e78f609 --internet-gateway-id igw-06c2d483e1c908eee
$ aws ec2 create-route-table --vpc-id vpc-0f52836626e78f609
{
    "RouteTable": {
        "Routes": [
            {
                "DestinationCidrBlock": "10.0.0.0/16",
                "GatewayId": "local",
                "State": "active",
                "Origin": "CreateRouteTable"
            }
        ],
        "Associations": [],
        "PropagatingVgws": [],
        "VpcId": "vpc-0f52836626e78f609",
        "RouteTableId": "rtb-06b95429f982aa033",
        "Tags": []
    }
}
$ aws ec2 create-route --route-table-id rtb-06b95429f982aa033 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-06c2d483e1c908eee
{
    "Return": true
}
$ aws ec2 describe-route-tables --route-table-id rtb-06b95429f982aa033
{
    "RouteTables": [
        {
            "RouteTableId": "rtb-06b95429f982aa033",
            "Associations": [],
            "Tags": [],
            "VpcId": "vpc-0f52836626e78f609",
            "Routes": [
                {
                    "Origin": "CreateRouteTable",
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "State": "active"
                },
                {
                    "Origin": "CreateRoute",
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "GatewayId": "igw-06c2d483e1c908eee",
                    "State": "active"
                }
            ],
            "PropagatingVgws": []
        }
    ]
}
$ aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-0f52836626e78f609" --query 'Subnets[*].{ID:SubnetId,CIDR:CidrBlock}'
[
    {
        "CIDR": "10.0.0.0/24",
        "ID": "subnet-066640bf3ca33b1e9"
    },
    {
        "CIDR": "10.0.1.0/24",
        "ID": "subnet-0cb1166c2a9de0d89"
    }
]
$ aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
$ chmod 400 MyKeyPair.pem
$ aws ec2 create-security-group --group-name SSHAccess --description "Security group for SSH access" --vpc-id vpc-0f52836626e78f609
{
    "GroupId": "sg-0eea5f8c0343f0ce5"
}

$ aws ec2 authorize-security-group-ingress --group-id sg-0eea5f8c0343f0ce5 --protocol tcp --port 22 --cidr 0.0.0.0/0
$ aws ec2 describe-images --owners 099720109477 --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????' 'Name=state,Values=available' --output json | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
ami-0b5edf72c627a56c9
$ aws ec2 run-instances --image-id ami-0b5edf72c627a56c9 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-0eea5f8c0343f0ce5 --subnet-id subnet-066640bf3ca33b1e9
{
    "Instances": [
        {
            "KeyName": "MyKeyPair",
            "PrivateDnsName": "ip-10-0-0-48.ap-northeast-2.compute.internal",
            "Hypervisor": "xen",
            "AmiLaunchIndex": 0,
            "SubnetId": "subnet-066640bf3ca33b1e9",
            "SecurityGroups": [
                {
                    "GroupId": "sg-0eea5f8c0343f0ce5",
                    "GroupName": "SSHAccess"
                }
            ],
            "BlockDeviceMappings": [],
            "EbsOptimized": false,
            "Placement": {
                "Tenancy": "default",
                "AvailabilityZone": "ap-northeast-2c",
                "GroupName": ""
            },
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "InstanceType": "t2.micro",
            "NetworkInterfaces": [
                {
                    "OwnerId": "174186896117",
                    "MacAddress": "0a:13:21:2e:28:de",
                    "NetworkInterfaceId": "eni-004fddcfa55222391",
                    "SubnetId": "subnet-066640bf3ca33b1e9",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateIpAddress": "10.0.0.48"
                        }
                    ],
                    "Attachment": {
                        "AttachTime": "2019-06-19T05:37:20.000Z",
                        "DeleteOnTermination": true,
                        "AttachmentId": "eni-attach-0b79d47014ad2ad6a",
                        "Status": "attaching",
                        "DeviceIndex": 0
                    },
                    "PrivateIpAddress": "10.0.0.48",
                    "Description": "",
                    "SourceDestCheck": true,
                    "VpcId": "vpc-0f52836626e78f609",
                    "Status": "in-use",
                    "Groups": [
                        {
                            "GroupId": "sg-0eea5f8c0343f0ce5",
                            "GroupName": "SSHAccess"
                        }
                    ]
                }
            ],
            "InstanceId": "i-0216dd5354715c78b",
            "VpcId": "vpc-0f52836626e78f609",
            "ProductCodes": [],
            "StateTransitionReason": "",
            "RootDeviceName": "/dev/sda1",
            "PublicDnsName": "",
            "PrivateIpAddress": "10.0.0.48",
            "VirtualizationType": "hvm",
            "Monitoring": {
                "State": "disabled"
            },
            "Architecture": "x86_64",
            "RootDeviceType": "ebs",
            "SourceDestCheck": true,
            "LaunchTime": "2019-06-19T05:37:20.000Z",
            "ClientToken": "",
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "ImageId": "ami-0b5edf72c627a56c9"
        }
    ],
    "Groups": [],
    "OwnerId": "174186896117",
    "ReservationId": "r-08ab98c8b7b9e01ec"
}
$ aws ec2 describe-instances --instance-id i-0216dd5354715c78b
{
    "Reservations": [
        {
            "ReservationId": "r-08ab98c8b7b9e01ec",
            "OwnerId": "174186896117",
            "Instances": [
                {
                    "KeyName": "MyKeyPair",
                    "RootDeviceName": "/dev/sda1",
                    "StateTransitionReason": "",
                    "AmiLaunchIndex": 0,
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "ImageId": "ami-0b5edf72c627a56c9",
                    "ProductCodes": [],
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/sda1",
                            "Ebs": {
                                "AttachTime": "2019-06-19T05:37:21.000Z",
                                "Status": "attached",
                                "DeleteOnTermination": true,
                                "VolumeId": "vol-018645c987548f6e6"
                            }
                        }
                    ],
                    "SourceDestCheck": true,
                    "InstanceId": "i-0216dd5354715c78b",
                    "NetworkInterfaces": [
                        {
                            "Status": "in-use",
                            "Attachment": {
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "DeleteOnTermination": true,
                                "AttachTime": "2019-06-19T05:37:20.000Z",
                                "AttachmentId": "eni-attach-0b79d47014ad2ad6a"
                            },
                            "MacAddress": "0a:13:21:2e:28:de",
                            "PrivateIpAddress": "10.0.0.48",
                            "SourceDestCheck": true,
                            "OwnerId": "174186896117",
                            "PrivateIpAddresses": [
                                {
                                    "PrivateIpAddress": "10.0.0.48",
                                    "Primary": true
                                }
                            ],
                            "Description": "",
                            "SubnetId": "subnet-066640bf3ca33b1e9",
                            "VpcId": "vpc-0f52836626e78f609",
                            "Groups": [
                                {
                                    "GroupId": "sg-0eea5f8c0343f0ce5",
                                    "GroupName": "SSHAccess"
                                }
                            ],
                            "NetworkInterfaceId": "eni-004fddcfa55222391"
                        }
                    ],
                    "RootDeviceType": "ebs",
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "LaunchTime": "2019-06-19T05:37:20.000Z",
                    "SubnetId": "subnet-066640bf3ca33b1e9",
                    "VpcId": "vpc-0f52836626e78f609",
                    "Placement": {
                        "AvailabilityZone": "ap-northeast-2c",
                        "Tenancy": "default",
                        "GroupName": ""
                    },
                    "SecurityGroups": [
                        {
                            "GroupId": "sg-0eea5f8c0343f0ce5",
                            "GroupName": "SSHAccess"
                        }
                    ],
                    "Hypervisor": "xen",
                    "PrivateIpAddress": "10.0.0.48",
                    "InstanceType": "t2.micro",
                    "State": {
                        "Name": "running",
                        "Code": 16
                    },
                    "ClientToken": "",
                    "PrivateDnsName": "ip-10-0-0-48.ap-northeast-2.compute.internal",
                    "VirtualizationType": "hvm",
                    "PublicDnsName": "",
                    "Architecture": "x86_64"
                }
            ],
            "Groups": []
        }
    ]
}
$ ssh -i "MyKeyPair.pem" ec2-user@10.0.0.48
~~~



---
layout: post
title: 'AWS CloudFormation' 
author: haeyeon.hwang
tags: [blockchain]
image: /assets/img/blog/aws.png
hide_image: true
---

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## AWS CloudFormation

Creating an Amazon Virtual Private Cloud (VPC) with AWS CloudFormation  
- An Amazon VPC
- An Internet Gateway
- Two Subnets
- Two Route Tables

**Amazon VPC**  
~~~yaml
AWSTemplateFormatVersion: 2010-09-09
Description: Deploy a VPC

Resources:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.0.0.0/16
      EnableDnsHostnames: true
      Tags:
      - Key: Name
        Value: Lab VPC
~~~

**Internet Gateway**  
~~~yaml
  InternetGateway:
    Type: AWS::EC2::InternetGateway
    Properties:
      Tags:
      - Key: Name
        Value: Lab Internet Gateway
~~~

**Attach Gateway to VPC**  
~~~yaml
  AttachGateway:
    Type: AWS::EC2::VPCGatewayAttachment
    Properties:
      VpcId: !Ref VPC
      InternetGatewayId: !Ref InternetGateway
~~~

**Build Subnet**  
~~~yaml
  PublicSubnet1:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.0.0/24
      AvailabilityZone: !Select
        - '0'
        - !GetAZs ''
      Tags:
        - Key: Name
          Value: Public Subnet 1

  PrivateSubnet1:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.1.0/24
      AvailabilityZone: !Select
        - '0'
        - !GetAZs ''
      Tags:
        - Key: Name
          Value: Private Subnet 1
~~~

!Select, !GetAZs means
Retrieving a list of Availability Zones with the region and is referencing the first element from the list.
In this manner, the list of Availability Zones at runtime rather than having the Availability Zones hard-coded in the template.

**Build RouteTable**  
~~~yaml
  PublicRouteTable:
    Type: AWS::EC2::RouteTable
    Properties:
      VpcId: !Ref VPC
      Tags:
        - Key: Name
          Value: Public Route Table

  PublicRoute:
    Type: AWS::EC2::Route
    Properties:
      RouteTableId: !Ref PublicRouteTable
      DestinationCidrBlock: 0.0.0.0/0
      GatewayId: !Ref InternetGateway
~~~


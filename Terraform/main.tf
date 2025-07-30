terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

module "S3" {
  source = "./modules/S3"
  bucketname = var.bucketname
  keyname = var.keyname
  sourceoffile = var.sourceoffile
}

module "iam" {
  source = "./modules/iam"
  instance-id = module.ec2.instance-id
  bucket-name = var.bucketname
  start-function-name-ec2 = var.start-function
  stop-function-name-ec2 = var.stop-function
}

module "ec2" {
  source = "./modules/ec2"
  security-group-id = module.security-group.security-group-id
  subnet-id = module.vpc.subnet-id  
  instance-profile = module.iam.instane-profile
}

module "vpc" {
  source = "./modules/vpc"
}

module "security-group" {
  source = "./modules/security-group"
  vpc-id = module.vpc.vpc-id
}

module "lambda" {
  source = "./modules/lambda"
  region = var.region
  rolename = module.iam.lambda-iam-rolearn
  instance-id-lambda = module.ec2.instance-id
  start-function-name = var.start-function
  stop-function-name = var.stop-function
}

module "eventwatch" {
  source = "./modules/eventwatch"
  role-arn = module.iam.eventwatch-role-arn
  lambda-start-arn = module.lambda.start-lambda-arn
  lambda-stop-arn = module.lambda.stop-lambda-arn
} 

output "instance-public_ip" {
  value = module.ec2.public-ip
}

output "instance-id-ec2" {
  value = module.ec2.instance-id
}

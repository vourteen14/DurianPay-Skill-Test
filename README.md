# Problem #1

## Setup IAM
- create iam user with permission AdministratorAccess
- create access key for the iam user

## Setup aws cli
aws configure

## Put required value
- AWS Access Key
- AWS Secret key
- Region: us-east-1

## Create Bucket for terraform
aws s3api create-bucket --bucket durianpay-bucket-angga-suriana --region us-east-1

## Run terraform
cd terraform

terraform init

terraform plan

terraform apply -auto-approve

# Problem #2
- Create ec2 VM & generate public key
- On the VM, install docker, make sure the docker is running, and make sure http port is open
- Generate ssh key
  - ssh-keygen -t rsa -b 4096 -C "angga@durianpay.com"
- Based on generate key result, copy the geneated public key and paste the public key to ec2-user authorized_keys file
- Set repository variable
  - DOCKER_PASSWORD = docker token with write access
  - DOCKER_USERNAME = docker username
  - SSH_HOST        = public ip of vm that created before
  - SSH_PRIVATE_KEY = private key value that generated before
- Create push for automatically build and push container to dockerhub with development tag, i use github action for make the automation
- Create release and tag for automatically build, push, and deploy to ec2 vm that created before, i use github action for make the automation

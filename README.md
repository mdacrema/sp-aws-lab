# SP AWS Lab

This repo contains basic Terraform code that creates:
 * Autoscaling group with launch template that ensure at least 1 instance is running
 * Application Load Balancer that listen on plain HTTP port and logs access on a S3 bucket and forward to ASG Target Group
 * Related IAM roles and policies and Security Group to allow SSH and HTTP from personal IP

It also output the DNS name of the ALB to test everything is working

## Usage
There are two folders:
* *no_modules* which contains terraform code that doesn't use AWS official terraform modules
* *with_aws_modules* which contains terraform code that use AWS official terraform modules

1. Modify tf_config.sh to match your AWS creds and TF folder and exec 
```bash
source tf_config.sh
```
2. Run terraform init to initialise terraform 
```bash
docker run  --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY -v $PWD/$TF_FOLDER:/tf hashicorp/terraform:1.0.4 -chdir=/tf init
```
3. Plan  
```bash
docker run  --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY -v $PWD/$TF_FOLDER/:/tf hashicorp/terraform:1.0.4 -chdir=/tf plan
```
4. Apply 
```bash
docker run  --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY -v $PWD/$TF_FOLDER/:/tf hashicorp/terraform:1.0.4 -chdir=/tf apply --auto-approve
```
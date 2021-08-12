# SP AWS Lab

This repo contains basic Terraform code that creates:
 * Autoscaling group that ensure at least 1 instance is running
 * Launch template with userdata that installs httpd,tomcat and mysql at boot 
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
docker run  --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY -v $PWD:/tf hashicorp/terraform:1.0.4 -chdir=/tf/$TF_FOLDER init -var-file=/tf/lab.tfvars
```
3. Plan  
```bash
docker run  --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY -v $PWD:/tf hashicorp/terraform:1.0.4 -chdir=/tf/$TF_FOLDER plan -var-file=/tf/lab.tfvars
```
4. Apply 
```bash
docker run  --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY -v $PWD:/tf hashicorp/terraform:1.0.4 -chdir=/tf/$TF_FOLDER apply --auto-approve -var-file=/tf/lab.tfvars
```
5. Destroy
Empty S3 bucket using AWS console and run
```bash
docker run  --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY -v $PWD:/tf hashicorp/terraform:1.0.4 -chdir=/tf/$TF_FOLDER destroy --auto-approve -var-file=/tf/lab.tfvars
```

## Improvements

* Configuration management: Add an ansible playbook to better manage installed software its version and configuration
* Terraform: Use an existing s3 bucket as a backend for terraform states
* Infra: Create private subnets with a NAT Gateway ( not free tier eligible ) and deploy ec2 instance on them. Then expose application through an internet-facing ALB on public subnets
* Infra: Configure DB to use EBS volume ( on the same instance or better on a separate ec2 instance ) 
* Infra: Remove SSH key from instance and configure IAM roles to access via AWS Session Manager
* Infra: buy and host a DNS Zone on Route53 and expose services via HTTPS and redirect HTTP to HTTPS ( i.e. let's encrypt certificate for free certs )
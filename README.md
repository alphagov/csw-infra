# csw-infra
Cloud Security Watch - Infrastructure

## Instructions

The below does not cover how you supply your AWS credentials to terraform. 

This script allows you to deploy the same terraform configuration to multiple environments in separate accounts and VPCs. 

This means that in our AWS test account we can defined a VPC for each developer containing their own public and private subnets and a small 
RDS instance. 

Similarly we can use the same script to provision multiple separate 
test environments uat, qa... 

Because the tfstate lives in a separate folder you can have multiple independent tfstates rather than one terraform apply destroying the resources created by another. 

### Creating an environment 

1. Create a folder for your environment 

	`mkdir uat`
	`cd uat`

2. Copy the variables.tf and secrets folder from /env
3. Customize the variables file 

	1. Add your environment name as a prefix 
	2. Add the next available subnet range to all the CIDRs
	3. Add a default RDS root password in secrets

4. Symlink terraform files into your environment 
	
	`ln -fs ../terraform/*.tf .`

5. Initialise terraform 
	
	`terraform init`

6. Run terraform 

	`terraform apply`

7. Delete your environment 

	`terraform destroy`


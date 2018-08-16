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

1. Create a folder in tools/csw/environments for your environment 
	your name for a dev env or uat, qa, prod... 

2. Copy the tfvars files from example environment and populate the <placeholders>

Environments are ignored by default except for the placeholder example_environment. 

*TODO We need to find a way to store and share the tfvars file for test and production environments*

### Initialising or switching environment

Change directory to `tools/csw` 	

`terraform init -backend-config=environments/<your env>/backend.tfvars -var-file=environments/<your env>/apply.tfvars -reconfigure`

Because it's running in the same folder if you go switch the apply.tfvars for a different env you first need to tell 
terraform to use the different backend-config and -reconfigure makes it reload the backend state if it's already defined

### Test the configuration	

Change directory to `tools/csw` 	

`terraform plan -var-file=environments/<your env>/apply.tfvars`

If init runs successfully without errors you should be OK to apply 

### Apply the configuration 

Change directory to `tools/csw` 	

`terraform apply -var-file=environments/<your env>/apply.tfvars`


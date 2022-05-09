# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, we have a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

Packer template will create an Ubuntu 18.04-LTS SKU as base image.

Terraform will deploy:
- a Resource Group
- a Virtual network and a subnet on that virtual network.
- a Network Security Group that explicitly allow access to other VMs on the subnet and deny direct access from the internet.
- a Network Interface.
- a Public IP.
- a Load Balancer with a backend address pool and address pool association for the network interface and the load balancer.
- a virtual machine availability set.
- the managed disks for your virtual machines.
- the virtual machines using packer image deployed mentioned.
  
You can modify a packer image in builder section with your own needs.


### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
Once you've collected your dependencies, run these following steps:
1. Create a resource group: az group create -n [name] -l [location]
2. Create an App Registration in Azure Portal (following the instruction here https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
3. Set client_id, client_secret, subscription_id to envs
4. Create image with packer from template file: packer build .\server.json
5. Import the resource group to terraform state: terraform import terraform_id azure_resource_id
   For my case: terraform import azurerm_resource_group.main /subscriptions/xxx-xxx-xxx-xxx-xxx/resourceGroups/finalproject1-rg
6. See the terraform plan: terraform plan -out solution.plan
7. Apply terraform plan: terraform apply .\solution.plan
   
Go to azure portal and see the result.
 


### Output
With the number of VMs is 2 as default, there will be:

- 1 image created
- 4 disks created
- 1 load balancer created
- 1 network security group created
- 1 public IP address created
- 2 regular network interface created
- 2 virtual machine created
- 1 virtual network created
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

You use variables in your configuration with var.<variable_name> to replace the hard-coded value in this file. Variable blocks of variables.tf file have optional arguments:

- Description, a description to briefly tell the purpose of the variable and display when using this variable.
- Type, the type of data contained in the variable, the supported type keywords are: string, number, bool, list(<TYPE>), map(<TYPE>), set(<TYPE>), tuple(<TYPE>), object({<ATTR NAME> = <TYPE>, ... }). The keyword any can be used to show that any type is acceptable.
- Default, the default value.
- Validation, a block to define validation rules, usually in addition to type constraints.
- Sensitive, it limits Terraform UI output when the var is used in configuration.
- Nullable, you can use if the variable can be null within the module.

--> The var declaration can include a default argument. If present, the var is marked as optional and the default value will be used if no value is set when running Terraform.

--> Type constraints are optional.

--> Validation is a block that can specify arbitrary custom validation rules for a particular var.

Ex: variable "location" {
   type = string
   description = "The Azure Region in which all resources in this example should be created."

   validation {
      condition     = var.location == "eastasia"
      error_message = "Sorry, but we only accept East Asia region."
   }
}

--> Sensitive prevents Terraform from showing its value in the plan or apply output, when you use that variable elsewhere in your configuration.

--> The nullable argument in a variable block controls if the module caller may assign the value null to the var.

You can modify a packer image in builder section with your own needs as well.


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

- 1 image created (from Packer)
- 4 disks created (from Terraform)
- 1 load balancer created (from Terraform)
- 1 network security group created (from Terraform)
- 1 public IP address created (from Terraform)
- 2 regular network interface created (from Terraform)
- 2 virtual machine created (from Terraform)
- 1 virtual network created (from Terraform)
   
   The output from terraform plan:
   
   ![image](https://user-images.githubusercontent.com/18424851/167684654-d9122638-6461-4625-9a1d-e86f4acc7867.png)
   
   ![image](https://user-images.githubusercontent.com/18424851/167684734-66a247bd-d4aa-4769-bc87-67de1731d5c4.png)
   
   The output from building packer image:
   
   ![image](https://user-images.githubusercontent.com/18424851/167685911-8e8e324a-d3ca-4d98-8b2f-6c30534c8749.png)



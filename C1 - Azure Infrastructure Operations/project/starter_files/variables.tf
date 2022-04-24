variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "finalproject1"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "vm_names" {
  description = "Name of the Virtual Machine"
  type = list(string)
  default = ["vm1", "vm2"]
}

variable "packer_image_name" {
  description = "Name of the Packer image"
  default     = "myPackerImage"
}

variable "username" {
  description = "Username"
}

variable "password" {
  description = "Strong password"
}

variable "address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "location" {
  description = "location "
  type        = string
  sensitive   = true
}

variable "vnet_name" {
  type = string
  default = "azureVN"
}

variable "resource_group_name" {
  type = string
}

variable "private_subnet_count" {
  type    = number
  default = 2
}


variable "address_prefixes" {
    type = list(string)
  default = [
    "10.0.2.0/24",
    "10.0.3.0/24"
     ]
}
variable "resource_group_name" {
  type = string
}

variable "location" {
  description = "location "
  type        = string
  sensitive   = true
}

variable "nic_name" {
  type = string
  default = "nic-akz"
}

variable "subnet_id" {
  type = string
}

variable "public_ip_address_id" {
  type = string
}

variable "nsg_name" {
  type = string
  default = "nsg"
}
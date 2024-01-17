variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "The IPv4 CIDR block for the public subnet. The CIDR block must fit within the range of the VPC CIDR range."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "The IPv4 CIDR block for the private subnet. The CIDR block must fit within the range of the VPC CIDR range."
  type        = string
  default     = "10.0.10.0/24"
}

variable "public_subnet_az" {
  description = "The availability zone for the public subnet."
  type        = string
  default     = "us-east-1a"
}

variable "private_subnet_az" {
  description = "The availability zone for the private subnet."
  type        = string
  default     = "us-east-1b"
}

variable "k8s_instance_type" {
  description = "The instance type to use for the cluster. Note that the default instance type t3a.small is not available in all regions or availability zones."
  type        = string
  default     = "t3a.small"
}

variable "bastion_host_key_name" {
  description = "The name of the bastion host SSH key"
  type        = string
  default     = "bastion_host_key"
}

variable "k8s_key_name" {
  description = "The name of the kubernetes node SSH key"
  type        = string
  default     = "k8s_key"
}

variable "worker_count" {
  description = "Count of worker nodes to deploy"
  type        = number
  default     = 1
}

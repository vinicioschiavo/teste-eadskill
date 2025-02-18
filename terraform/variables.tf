variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR block"
  default     = "10.0.2.0/24"
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  default     = "eadskill-cluster"
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  default     = "1.32"
}


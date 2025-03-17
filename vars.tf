variable "region" {
  default = "us-west-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "ssh_port" {
  default = 22
}

variable "http_port" {
  default = 80
}

variable "http" {
  default = 8080
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "dest_cidr" {
  default = "0.0.0.0/0"
}

variable "key" {
  default = "armen"
}

variable "ami_owner" {
  default     = "099720109477"
}

variable "ubuntu_version" {
  default     = "22.04"
}

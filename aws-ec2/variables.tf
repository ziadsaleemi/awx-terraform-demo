variable "instance_name" {
  description = "Name tag for the EC2 instance."
  type        = string
  default     = "awx-demo-aws"
}

variable "aws_region" {
  description = "AWS region. AWX also injects AWS_DEFAULT_REGION from the AWS Terraform credential."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "ami_name_filter" {
  description = "AMI name filter for Ubuntu images."
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "vpc_id" {
  description = "Existing VPC ID. Leave empty to use the default VPC."
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Existing subnet ID. Leave empty to use the first subnet in the selected VPC."
  type        = string
  default     = ""
}

variable "assign_public_ip" {
  description = "Assign a public IP address to the instance."
  type        = bool
  default     = true
}

variable "ssh_key_name" {
  description = "Existing AWS EC2 key pair name. Leave empty to launch without a key pair."
  type        = string
  default     = ""
}

variable "ssh_cidr_blocks" {
  description = "CIDR ranges allowed to SSH to the instance."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags to apply to created resources."
  type        = map(string)
  default = {
    managed_by = "awx"
    demo       = "terraform"
  }
}

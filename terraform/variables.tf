variable "aws_credentials" {
    description = "this variable holds your AWS credentials which is assumed to be in your home dir"
}

variable "region" {
    description = "region where this instance will be deployed"
}
variable "instance_config" {
    description = "config of your instance is defined using this var"
}
variable "ami_filter" {
    description = "it filter out the required AMI"
}

variable "ssh_user" {
    description = "non-root user with sudo previlege"
}
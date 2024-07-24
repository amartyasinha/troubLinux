aws_credentials = "$HOME/.aws/credentials"
region          = "us-east-1"

ssh_user = "ubuntu"

instance_config = {
  instance_type    = "t2.micro"
  key_name         = "my-key" # Replace with your key name that exists in AWS
  root_volume_size = 8
  root_volume_type = "gp3"
}

ami_filter = {
  most_recent  = true
  owners       = "099720109477" # Canonical account ID for Ubuntu: Do not change it
  architecture = "x86_64"
  name         = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04*"
}
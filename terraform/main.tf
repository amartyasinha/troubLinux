resource "aws_default_subnet" "default_subnet" {
    availability_zone = "${var.region}a"

    tags = {
        Name = "Default subnet for this project"
  }
}

data "aws_ami" "ubuntu-ami-id" {
  most_recent = var.ami_filter["most_recent"]
  owners      = [var.ami_filter["owners"]]

  filter {
    name   = "architecture"
    values = [var.ami_filter["architecture"]]
  }

  filter {
    name   = "name"
    values = [var.ami_filter["name"]]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "troubLinux_instance" {
    ami = data.aws_ami.ubuntu-ami-id.id
    count = var.instance_config["count"]
    instance_type = var.instance_config["instance_type"]
    key_name = var.instance_config["key_name"]
    subnet_id = aws_default_subnet.default_subnet.id

    root_block_device {
        encrypted             = false
        delete_on_termination = true
        volume_size           = var.instance_config["root_volume_size"]
        volume_type           = var.instance_config["root_volume_type"]
  }

  tags = {
    Name        = "troubLinux"
    Environment = "test"
  }   
}
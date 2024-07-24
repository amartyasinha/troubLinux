locals {
  private_key_path = "~/keys/${var.instance_config["key_name"]}.pem"

}
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

resource "aws_security_group" "troubLinux_sg" {
  vpc_id = aws_default_subnet.default_subnet.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "troubLinux_instance" {
  ami             = data.aws_ami.ubuntu-ami-id.id
  instance_type   = var.instance_config["instance_type"]
  key_name        = var.instance_config["key_name"]
  subnet_id       = aws_default_subnet.default_subnet.id
  security_groups = [aws_security_group.troubLinux_sg.id]

  root_block_device {
    encrypted             = false
    delete_on_termination = true
    volume_size           = var.instance_config["root_volume_size"]
    volume_type           = var.instance_config["root_volume_type"]
  }

  # Ansible Integration borrowed from https://github.com/antonputra/tutorials/blob/main/lessons/014/main.tf#L47
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.troubLinux_instance.public_ip
    }
  }
  provisioner "local-exec" {
    command     = "ansible-playbook  -i ${aws_instance.troubLinux_instance.public_ip}, --private-key ${local.private_key_path} test.yml"
    working_dir = "${path.module}/../tests"
  }
  tags = {
    Name        = "troubLinux"
    Environment = "test"
  }
}

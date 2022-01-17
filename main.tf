data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["prime"]
  }
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["public"]
  }
}
/*

data "aws_security_group" "www" {
  filter {
    name   = "tag:Name"
    values = ["allow_web"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = ["allow_ssh"]
  }
}

data "terraform_remote_state" "aws_security_group" {
  backend "s3" 
    config {
      bucket = "2112it"
      key    = "terraform/security/terraform.tfstate"
      region = "eu-west-2"
    }
  }
*/

data "terraform_remote_state" "sec" {
  backend = "s3"

  config = {
    region = "eu-west-2"
    bucket = "2112it"
    key    = "terraform/security/terraform.tfstate"
  }
}

resource "aws_instance" "web1" {
  subnet_id              = data.aws_subnet.selected.id
  ami                    = var.ami
  instance_type          = "t4g.nano"
  vpc_security_group_ids = [data.terraform_remote_state.sec.outputs.security_group_allow_web]
  key_name               = "terraform-test-key"
  user_data              = <<EOF
#!/bin/bash
amazon-linux-extras install nginx1
yum install -y php70-fpm
echo "<?php phpinfo(); ?>" > /usr/share/nginx/html/index.php
systemctl start nginx
EOF
}


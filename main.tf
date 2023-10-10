# main.tf

provider "aws" {
  access_key = ""   # place access keys here
  secret_key = ""   # place secret key here
  region = "us-east-1" # Replace with your desired AWS region
}

# Create a new EC2 instance in the other public subnet of your VPC.

resource "aws_instance" "jenkins" {
  name = "jenkins"
  ami = "ami-06756d650220756d8"  # Ubuntu 18.04 LTS
  instance_type = "t2.micro"
  subnet_id = var.subnet_id  # The other public subnet in your VPC
  vpc_security_group_ids = [var.security_group_id]  # Allow SSH and HTTP traffic

  # Install Jenkins on the EC2 instance.
  provisioner "local-exec" {
    command = "bash deploy.sh"
  }
}

  tags = {
    Name = "project-subnet-public1-us-east-1a"
  }
}

# Output the IP address of the EC2 instance to the terminal.
output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
}

# Terraform Documentation

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Using Terraform](#using-terraform)
  - [Initializing a Terraform Project](#initializing-a-terraform-project)
  - [Writing Terraform Configuration](#writing-terraform-configuration)
  - [Displaying Terraform plan](#displaying-a-plan/outline-of-the-terraform-configuration)
  - [Applying Terraform Configuration](#applying-terraform-configuration)


## Introduction

This README provides a brief overview of using Terraform, an infrastructure as code (IaC) tool. Terraform allows you to define and provision infrastructure resources in a declarative configuration file, making it easier to manage, version, and automate your infrastructure.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following prerequisites:

1. [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
2. Access to a cloud provider or other infrastructure platforms where you want to provision resources.

### Installation

1. Download and install Terraform by following the official [installation instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli).

2. Verify the installation by running the following command:

   ```shell
   terraform --version
   ```

   This should display the installed Terraform version.

## Using Terraform

### Initializing a Terraform Project

1. Create a new directory for your Terraform project.

2. Inside the project directory, create a file named `main.tf`. This is where you'll define your infrastructure resources.

3. Initialize your Terraform project by running:

   ```shell
   terraform init
   ```

   This command downloads any necessary plugins and sets up the working directory.

### Writing Terraform Configuration

Define your infrastructure resources in the `main.tf` file using HashiCorp Configuration Language (HCL). 

- Step 1: Define resources name(AWS,Jenkins), instance type, ami, new subnet_id, and VPC security groups for new instance
  

```hcl
 resource "aws_instance" "jenkins" {
  name = "jenkins"
  ami = "ami-06756d650220756d8"  # Ubuntu 18.04 LTS
  instance_type = "t2.2xlarge"
  subnet_id = var.subnet_id  # The other public subnet in your VPC
  vpc_security_group_ids = [var.security_group_id]  # Allow SSH and HTTP traffic
}
```

- Step 2: Declare Jenkins Installation

```hcl
 provisioner "local-exec" {
    command = "bash deploy.sh"
  }
}
```

This is where you will define the bash script that has every command needed to install jenkins


- Step 3: Output the IP address of the EC2 Instance to the terminal
  ```hcl
    output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
  }
  ```
  

### Displaying a plan/outline of the-terraform configuration

```hcl
  terraform plan
```
Use the ```terraform plan``` command to give you an outline of your configuration and ensure that everything is accurate so that Terraform can provision the infrastructure to suit your exact desire


### Applying Terraform Configuration

1. After writing your Terraform configuration, apply it by running:

   ```shell
   terraform apply
   ```

   Terraform will create or update the resources defined in your configuration.

2. Confirm the changes by typing `yes` when prompted.




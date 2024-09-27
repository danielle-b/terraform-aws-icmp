# terraform-aws-icmp

How to Allow ICMP Traffic Between Two EC2 Instances Using Terraform

First, configure the AWS CLI in the terminal and create a directory for the Terraform project.

Create a main.tf file where all the configurations will live.

Using [Terraform AWS documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs?param1=value1&target=_blank), create two security groups. Both security groups must:
* Allow SSH traffic
* Allow outbound traffic
* Allow HTTP & HTTPS traffic

Create two security group rules that allow ICMP traffic between the instances. The group rules must include:
* type
* from_port
* to_port
* protocol
* security_group_id (This is where the ICMP traffic is going)
* source_security_group_id (The source is where the ICMP traffic is coming from)

Using the official [Terraform AWS Tutorial](https://developer.hashicorp.com/terraform/tutorials/aws-get-started?param1=value1&target=_blank) as a guide, create two EC2 instances. The configuration for the instances must include the following:
* key pair
* security groups that were just created
* instance_type
* ami (Be sure that the ami chosen is in the region you are using)

Once your instances have been created, ssh into one of the instances and use the Public IPv4 DNS to ping into the other.


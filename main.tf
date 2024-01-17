data "aws_vpc" "selected" {
  default = true
}


resource "aws_security_group" "ec2_securiy_group" {
  name = "ec2-securiy_group"
  vpc_id = data.aws_vpc.selected.id
  tags = {
    name = "Terraform-Kubernetes-Microservice-Phonebook"
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
 
  }
  ingress {
    from_port   = 30001
    protocol    = "tcp"
    to_port     = 30002
    cidr_blocks = ["0.0.0.0/0"]
 
  }


  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
}
  
resource "aws_instance" "tf_ec2" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3a.medium"
  key_name      = "firstkey"
  user_data = base64encode(file("user-data.sh"))

  tags = {
    "Name" = "EC2-Terraform-Kubernetes-Microservice-Phonebook"
  }

}

output "ec2-ip-no" {
  value = aws_instance.tf_ec2.public_ip
  
}
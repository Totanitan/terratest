resource "aws_instance" "hello" {
  ami = "ami-0701e21c502689c31"
  subnet_id = aws_subnet.aws-tf-public-subnet.id
  vpc_security_group_ids = [ 
      aws_security_group.ec2_sg.id
   ]
  instance_type = "t3.micro"
  key_name = "sitti.key"
  tags = {
    Name = "test_instance"
  }
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
uname -n > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
EOF
}

resource "aws_security_group" "ec2_sg" {
    name = "example-ec2-sg"
    description = "EC2 Security Group"
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "example-sg"
    }
}

resource "aws_security_group_rule" "example_ec2_in_http"{
    security_group_id = aws_security_group.ec2_sg.id
    type = "ingress"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "example_ec2_in_ssh"{
    security_group_id = aws_security_group.ec2_sg.id
    type = "ingress"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["14.10.4.128/32"]
}

resource "aws_security_group_rule" "ec2_out" {
    security_group_id = aws_security_group.ec2_sg.id
    type = "egress"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
}
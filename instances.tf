# AWS provider configuration
provider "aws" {
  region = "us-east-1"
}

# Create two EC2 instances
resource "aws_instance" "webserver" {
  count         = 2
  ami           = "ami-084568db4383264d4"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.load_balancer_sec_group.id]
  subnet_id              = element(aws_subnet.public_subnet[*].id, count.index)

  user_data = file("./setup-nginx.sh")

  # Updated: Added tag using join() function for dynamic naming
  tags = {
    Name = join("-", ["WebServer", "Lab9", tostring(count.index)])
  }
}

# IAM profile for instances
resource "aws_iam_instance_profile" "nginx_profile" {
  name = "nginx_profile"
  role = "LabRole"
}

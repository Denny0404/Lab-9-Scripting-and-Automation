#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
aws s3 sync s3://prog8830-lab-9-${random_id.s3_id.hex}/webcontent/ /home/ec2-user/

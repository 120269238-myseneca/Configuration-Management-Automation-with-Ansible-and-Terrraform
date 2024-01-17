data "aws_ami" "al2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# See the following for more information for migrating base image to AL2023:
# https://github.com/amazonlinux/amazon-linux-2023/issues/528
# https://github.com/amazonlinux/amazon-ec2-net-utils/issues/97
data "aws_ami" "al2023" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

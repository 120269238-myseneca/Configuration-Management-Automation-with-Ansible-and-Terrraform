resource "aws_instance" "bastion_host" {
  count                       = 1
  instance_type               = "t3a.nano"
  ami                         = data.aws_ami.al2023.id
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.bastion_host.id]
  key_name                    = aws_key_pair.bastion_host.key_name
  associate_public_ip_address = true

  tags = {
    Name    = "bastion"
    role    = "bastion_host"
    service = "k8s"
  }
}

resource "aws_key_pair" "bastion_host" {
  key_name   = "bastion_host_key"
  public_key = file("${var.bastion_host_key_name}.pub")
}

resource "aws_security_group" "bastion_host" {
  vpc_id = aws_vpc.k8s_cluster.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

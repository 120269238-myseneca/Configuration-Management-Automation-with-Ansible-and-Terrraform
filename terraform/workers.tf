resource "aws_instance" "k8s_workers" {
  count                  = var.worker_count
  instance_type          = var.k8s_instance_type
  ami                    = data.aws_ami.al2.id
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.k8s_workers.id]
  key_name               = aws_key_pair.k8s.key_name

  tags = {
    Name    = "worker"
    role    = "worker"
    service = "k8s"
  }
}

resource "aws_security_group" "k8s_workers" {
  vpc_id = aws_vpc.k8s_cluster.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 10250
    to_port     = 10250
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 30000
    to_port     = 32767
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

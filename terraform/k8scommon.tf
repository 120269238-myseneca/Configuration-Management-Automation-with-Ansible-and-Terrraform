resource "aws_key_pair" "k8s" {
  key_name   = "k8s_key"
  public_key = file("${var.k8s_key_name}.pub")
}

output "bastion_host_public_ip" {
  value = aws_instance.bastion_host[*].public_ip
}

output "bastion_host_private_ip" {
  value = aws_instance.bastion_host[*].private_ip
}

output "control_plane_private_ip" {
  value = aws_instance.k8s_cp[*].private_ip
}

output "worker_private_ip" {
  value = aws_instance.k8s_workers[*].private_ip
}

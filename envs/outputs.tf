output "ec2_start_command" {
  value = <<-EOT
    aws ec2 start-instances --instance-ids ${module.ec2.instance_id} --profile admin
  EOT
}

output "ec2_stop_command" {
  value = <<-EOT
    aws ec2 stop-instances --instance-ids ${module.ec2.instance_id} --profile admin
  EOT
}

output "ec2_status_command" {
  value = <<-EOT
    aws ec2 describe-instances \
    --instance-ids ${module.ec2.instance_id} \
    --query "Reservations[].Instances[].State.Name" \
    --profile admin
  EOT
}

output "ssm_command" {
  value = <<-EOT
    ssh -i ./.key/keypair.pem ec2-user@${module.ec2.instance_id} \
    -o ProxyCommand="sh -c 'aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters portNumber=%p --profile admin'"
  EOT
}
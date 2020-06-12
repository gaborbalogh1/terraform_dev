output "instance_ips" {
  value = ["${aws_instance.Dev-mirror.*.public_ip}"]
}

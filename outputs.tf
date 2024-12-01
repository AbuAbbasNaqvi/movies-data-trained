output "public_ip" {
  description = "The public IP of the Jenkins server"
  value       = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  description = "The URL to access Jenkins"
  value       = "http://:"
}

output "prometheus_url" {
  description = "The URL to access Prometheus"
  value       = "http://:"
}

output "grafana_url" {
  description = "The URL to access Grafana"
  value       = "http://:"
}

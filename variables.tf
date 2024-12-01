variable "instance_type" {
  description = "Instance type for EC2 instances"
  default     = "t2.large"
}

variable "key_name" {
  description = "Key pair for SSH access to EC2 instances"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the Ubuntu 22.04 image"
  type        = string
}

variable "jenkins_port" {
  description = "Port for Jenkins web UI"
  default     = 8080
}

variable "prometheus_port" {
  description = "Port for Prometheus web UI"
  default     = 9090
}

variable "grafana_port" {
  description = "Port for Grafana web UI"
  default     = 3000
}

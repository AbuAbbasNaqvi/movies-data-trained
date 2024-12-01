resource "aws_instance" "jenkins_server" {
  ami           = var.ami_id  # Use the provided AMI ID
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "Jenkins-Server"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y openjdk-11-jdk docker.io jq wget
    sudo systemctl start docker
    sudo systemctl enable docker

    # Install Jenkins
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    # Install Prometheus
    sudo apt install -y prometheus

    # Install Grafana
    sudo apt install -y grafana
    sudo systemctl start grafana-server
    sudo systemctl enable grafana-server

    # Dockerize SonarQube
    docker pull sonarqube
    docker run -d -p 9000:9000 sonarqube
  EOF
}

resource "aws_security_group" "jenkins_sg" {
  name_prefix = "jenkins-sg-"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  value = "http://:"
}

output "prometheus_url" {
  value = "http://:"
}

output "grafana_url" {
  value = "http://:"
}

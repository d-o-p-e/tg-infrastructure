resource "aws_security_group" "tg_backend_sg" {
  name        = "tg-backend-${var.environment}-sg"
  description = "TG backend EC2 Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    protocol  = "TCP"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    protocol  = "TCP"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Test Port"
    protocol  = "TCP"
    from_port = 8080
    to_port   = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    protocol  = "TCP"
    from_port = 443
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    description = "all incoming traffic in SG"
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    description = "all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "tg-backend-${var.environment}-sg"
    Environment = var.environment
  }
}

resource "aws_network_interface" "tg_backend_network_interface" {
    subnet_id = var.subnet_ids[0]

    security_groups = [aws_security_group.tg_backend_sg.id]
}

resource "aws_instance" "tg_backend_server" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.tg_backend_network_interface.id
    device_index = 0
  }

  key_name = data.aws_key_pair.tg_key.key_name

  tags = {
    Name = "tg-${var.environment}-backend"
  }
}

resource "aws_eip" "tg_server_eip" {
  vpc = true
  network_interface = aws_network_interface.tg_backend_network_interface.id
  associate_with_private_ip = aws_network_interface.tg_backend_network_interface.private_ip
  depends_on = [aws_network_interface.tg_backend_network_interface]
}

resource "aws_lb_target_group" "tg_backend_target_group" {
  name        = "tg-backend-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.tg_backend_target_group.arn
  target_id        = aws_instance.tg_backend_server.id
  port             = 8080
}

resource "aws_lb" "tg_backend_alb" {
  name               = "tg-backend-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tg_backend_sg.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "tg_backend_lb_forward" {
  load_balancer_arn = aws_lb.tg_backend_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.tg_backend_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_backend_target_group.arn
  }
}

resource "aws_lb_listener" "tg_backend_redirect_http_to_https" {
  load_balancer_arn = aws_lb.tg_backend_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
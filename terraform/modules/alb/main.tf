resource "aws_lb" "this" {

  name = "${var.name}-alb"

  load_balancer_type = "application"

  internal = false

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = var.subnet_ids


  tags = {
    Name = "${var.name}-alb"
  }
}

resource "aws_lb_target_group" "this" {

  name = "${var.name}-tg"

  port = 80

  protocol = "HTTP"

  vpc_id = var.vpc_id


  health_check {

    enabled = true

    path = "/"

    matcher = "200-399"

    interval = 30

    healthy_threshold = 2

    unhealthy_threshold = 3

  }


  tags = {
    Name = "${var.name}-tg"
  }
}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"


  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn

  }

}


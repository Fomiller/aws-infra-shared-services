resource "aws_lb" "aws_infra" {
  name            = "${var.namespace}-lb"
  subnets         = aws_subnet.public_subnets[*].id
  security_groups = [aws_security_group.aws_infra_lb.id]
}

resource "aws_lb_target_group" "aws_infra" {
  name        = "${var.namespace}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.aws_infra.id
  target_type = "ip"
}

resource "aws_lb_listener" "aws_infra" {
  load_balancer_arn = aws_lb.aws_infra.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.aws_infra.id
    type             = "forward"
  }
}


# Removed because Not needed at this time. Using EKS controller to provision elb

# resource "aws_security_group" "aws_infra_lb" {
#   name   = "${var.namespace}-alb-security-group"
#   vpc_id = aws_vpc.aws_infra.id
#
#   ingress {
#     protocol    = "tcp"
#     from_port   = 80
#     to_port     = 80
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
#
# resource "aws_lb" "aws_infra" {
#   name            = "${var.namespace}-lb"
#   subnets         = aws_subnet.public[*].id
#   security_groups = [aws_security_group.aws_infra_lb.id]
# }
#
# resource "aws_lb_target_group" "aws_infra" {
#   name        = "${var.namespace}-target-group"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.aws_infra.id
#   target_type = "ip"
# }
#
# resource "aws_lb_listener" "aws_infra" {
#   load_balancer_arn = aws_lb.aws_infra.id
#   port              = "80"
#   protocol          = "HTTP"
#
#   default_action {
#     target_group_arn = aws_lb_target_group.aws_infra.id
#     type             = "forward"
#   }
# }
#

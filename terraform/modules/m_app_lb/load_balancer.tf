# create network load balancer
resource "aws_lb" "app_lb" {
    name = "eng74-fp-app_lb"
    load_balancer_type = "network"
    subnets = var.public_subnet_id
}

# target group
resource "aws_lb_target_group" "app_lb_target_group" {
    name = "eng74-fp-target_group"
    port = "80"
    protocol = "HTTP"
    vpc_id = var.vpc_id

    tags = {
        Name = "eng74-fp-target_group"
    }
}
# load balancer listener
resource "aws_lb_listener" "load_balancer_listener" {
    load_balancer_arn = aws_lb.load_balancer.arn
    port = "80"
    protocol = "TCP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.app_lb_target_group.arn
    }
}
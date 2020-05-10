resource "aws_elb" "elb" {
  name               = "terraform-elb"
 # availability_zones = ["eu-west-2a"]
  subnets            = ["${var.subnetid}"]
  security_groups    = ["${aws_security_group.elb_sg.id}"]
  internal           = true

  

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

  instances                   = ["${aws_instance.ec2_instance.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "terraform-elb"
  }
}

#elb_attachment
resource "aws_elb_attachment" "elb_attach" {
  elb      = "${aws_elb.elb.id}"
  instance = "${aws_instance.ec2_instance.id}"
}


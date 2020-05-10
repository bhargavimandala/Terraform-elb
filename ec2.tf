resource "aws_instance" "ec2_instance" {
  ami           = "${var.ami}"
  instance_type = "${var.instance}"
  key_name      = "${var.keyname}"
  iam_instance_profile = "${aws_iam_instance_profile.iam_profile.name}"
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  subnet_id     = "${var.subnetid}"
  user_data = "${file("userdata.sh")}"
  tags = {
    Name = "ec2-instance"
  }
}

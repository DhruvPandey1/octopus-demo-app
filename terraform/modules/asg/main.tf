resource "aws_launch_template" "this" {

  name = "${var.name}-launch-template"


  image_id = var.ami_id


  instance_type = var.instance_type


  vpc_security_group_ids = [
    var.security_group_id
  ]


  iam_instance_profile {

    name = var.instance_profile_name

  }

  user_data = base64encode(templatefile(
    "${path.module}/userdata.sh",
    {
      image               = var.image
      octopus_environment = var.octopus_environment
      octopus_role        = var.octopus_role
    }
  ))

  tags = {

    Name = "${var.name}-instance"

  }

}

resource "aws_autoscaling_group" "this" {


  name = "${var.name}-asg"


  vpc_zone_identifier = var.subnet_ids


  desired_capacity = var.name == "prod" ? 2 : 1


  min_size = 1


  max_size = 2



  launch_template {

    id = aws_launch_template.this.id

    version = "$Latest"

  }



  target_group_arns = [

    var.target_group_arn

  ]



  health_check_type = "ELB"



  tag {

    key = "Name"

    value = "${var.name}-ec2"

    propagate_at_launch = true

  }


}

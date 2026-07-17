variable "region" {
  type    = string
  default = "us-east-1"
}


variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}


variable "instance_type" {
  type    = string
  default = "t3.micro"
}


variable "ami_id" {
  type = string
}


variable "ecr_repository_url" {
  type = string
}


variable "image_tag" {
  type    = string
  default = "latest"
}

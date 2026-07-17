module "vpc" {

  source = "./modules/vpc"

  name = terraform.workspace

  cidr = var.vpc_cidr

}

module "security_group" {

  source = "./modules/security-groups"

  name = terraform.workspace

  vpc_id = module.vpc.vpc_id

}

module "iam" {

  source = "./modules/iam"

  name = terraform.workspace

}

module "alb" {

  source = "./modules/alb"


  name = terraform.workspace


  vpc_id = module.vpc.vpc_id


  subnet_ids = module.vpc.public_subnet_ids


  alb_security_group_id = module.security_group.alb_sg

}

module "asg" {

  source = "./modules/asg"

  name = terraform.workspace

  ami_id = var.ami_id

  instance_type = var.instance_type

  subnet_ids = module.vpc.public_subnet_ids

  security_group_id = module.security_group.ec2_sg

  instance_profile_name = module.iam.instance_profile_name

  target_group_arn = module.alb.target_group_arn

  image = local.image

  octopus_role = local.octopus_role[terraform.workspace]

  octopus_environment = local.octopus_environment[terraform.workspace]
}

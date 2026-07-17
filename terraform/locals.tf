locals {

  env = terraform.workspace


  instance_count = terraform.workspace == "prod" ? 2 : 1


  image = "${var.ecr_repository_url}:${var.image_tag}"

}

locals {

  octopus_environment = {
    dev  = "Development"
    uat  = "Testing"
    prod = "Production"
  }


  octopus_role = {
    dev  = "dev-web"
    uat  = "uat-web"
    prod = "prod-web"
  }

}

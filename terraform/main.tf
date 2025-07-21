provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"
  project_name = var.project_name
  aws_region   = var.aws_region
}

module "iam" {
  source = "../../modules/iam"
  project_name = var.project_name
}

module "ecr" {
  source = "../../modules/ecr"
  project_name = var.project_name
}

module "s3" {
  source = "../../modules/s3"
  project_name = var.project_name
}

module "rds" {
  source = "../../modules/rds"
  project_name = var.project_name
  db_username  = var.db_username
  db_password  = var.db_password
  db_name      = var.db_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
  sg_id        = module.vpc.db_sg_id
}

module "alb" {
  source = "../../modules/alb"
  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
  ecs_sg_id            = module.vpc.ecs_sg_id
  project_name         = var.project_name
  alb_target_port      = 80
}

module "ecs" {
  source = "../../modules/ecs"
  project_name         = var.project_name
  cluster_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_subnets
  alb_target_group_arn = module.alb.target_group_arn
  container_image_app  = var.container_image_app
  container_image_nginx= var.container_image_nginx
  task_exec_role_arn   = module.iam.ecs_task_exec_role_arn
  ecs_security_group   = module.vpc.ecs_sg_id
  db_env = {
    RDS_DB_NAME     = var.db_name
    RDS_USERNAME    = var.db_username
    RDS_PASSWORD    = var.db_password
    RDS_HOSTNAME    = module.rds.db_endpoint
    RDS_PORT        = "5432"
    S3_BUCKET_NAME  = module.s3.bucket_name
    S3_REGION_NAME  = var.aws_region
    LB_ENDPOINT     = module.alb.alb_dns
  }
}

output "alb_dns_name" {
  value = module.alb.alb_dns
}

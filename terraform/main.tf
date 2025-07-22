module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
}

module "rds" {
  source       = "./modules/rds"
  project_name = var.project_name
  subnet_ids   = var.subnet_ids
  sg_id        = var.sg_id
  db_name      = var.db_name
  db_username  = var.db_username
  db_password  = var.db_password
}

module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name
  subnet_ids   = var.subnet_ids
  sg_id        = var.sg_id
  vpc_id       = var.vpc_id
}

module "ecs" {
  source             = "./modules/ecs"
  project_name       = var.project_name
  image_url          = var.image_url
  subnet_ids         = var.subnet_ids
  sg_id              = var.sg_id
  region             = var.region
  execution_role_arn = module.iam.ecs_task_exec_role_arn
  db_host            = module.rds.db_endpoint
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  bucket_name        = module.s3.bucket_name
  target_group_arn   = module.alb.app_tg_arn
}

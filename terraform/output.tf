output "alb_dns_name" {
  value = module.alb.dns_name
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}
output "app_tg_arn" {
  value = aws_lb_target_group.app.arn
}

output "dns_name" {
  value = aws_lb.main.dns_name
}


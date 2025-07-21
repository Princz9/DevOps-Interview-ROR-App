resource "aws_ecs_cluster" "app_cluster" {
  name = "ror-app-cluster"
}

resource "aws_ecs_task_definition" "ror_task" {
  family                   = "ror-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "ror-app"
      image     = "${aws_ecr_repository.ror_app.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "DATABASE_HOST", value = aws_db_instance.postgres.address },
        { name = "DATABASE_NAME", value = var.db_name },
        { name = "DATABASE_USER", value = var.db_user },
        { name = "DATABASE_PASSWORD", value = var.db_password },
        { name = "S3_BUCKET", value = aws_s3_bucket.ror_bucket.bucket }
      ]
    }
  ])
}

resource "aws_ecs_service" "ror_service" {
  name            = "ror-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.ror_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets         = module.vpc.private_subnets
    assign_public_ip = false
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "ror-app"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.ecs_listener]
}

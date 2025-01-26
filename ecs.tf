resource "aws_ecs_cluster" "app_cluster" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "nodejs_task" {
  family                   = "nodejs-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"    # Add the cpu value
  memory = "512"    # Add the memory value

  container_definitions = jsonencode([{
    name      = "nodejs-app"
    image     = "piyushraj11/my-nodejs-app"   # Your Docker image URL
    essential = true
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
      }
    ]
  }])
}



resource "aws_ecs_service" "nodejs_service" {
  name            = "nodejs-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.nodejs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}

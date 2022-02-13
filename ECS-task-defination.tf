############################################################
# AWS ECS-TASK
############################################################

resource "aws_ecs_task_definition" "task_definition" {
  #container_definitions    = "${data.template_file.task_definition.rendered}"                                         # task defination json file location
  execution_role_arn       = aws_iam_role.ecs-instance-role.arn                                                                # role for executing task
  family                   = "openapi-task-defination"                                                                      # task name
  network_mode             = "awsvpc"                                                                                      # network mode awsvpc, brigde
  memory                   = "2048"
  cpu                      = "1024"
  requires_compatibilities = ["EC2"]                                                                                       # Fargate or EC2
  task_role_arn            = aws_iam_role.ecs-instance-role.arn
  container_definitions    = "${file("task_definition.json")}"
} 

//data "template_file" "task_definition" {
//  template = "${file("${path.module}/task_definition.json")}"
//}
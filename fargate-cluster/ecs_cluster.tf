// ECS Cluster
resource "aws_ecs_cluster" "ecs" {
  name = "${var.name}"
}

// FARGATE Execution Role
resource "aws_iam_role" "ecs_service_task_execution_role" {
  name_prefix = "EcsExecution-${var.name}-"

  assume_role_policy = "${data.aws_iam_policy_document.ecs_service_task_execution_role_assume.json}"
}

data "aws_iam_policy_document" "ecs_service_task_execution_role_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

// Attach  Default Execution Policy
resource "aws_iam_role_policy_attachment" "ecs_task_basic" {
  role       = "${aws_iam_role.ecs_service_task_execution_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

// Additional Policy to allow the task to manage cloudwatch log groups
resource "aws_iam_role_policy" "ecs_task_allow_awslogs" {
  name = "ecs-allow-awslogs"
  role = "${aws_iam_role.ecs_service_task_execution_role.id}"

  policy = "${data.aws_iam_policy_document.ecs_task_allow_awslogs_policy.json}"
}

data "aws_iam_policy_document" "ecs_task_allow_awslogs_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

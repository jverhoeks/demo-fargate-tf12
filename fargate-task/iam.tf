// Create IAM Role for this service
resource "aws_iam_role" "ecs_service_task_role" {
  name_prefix = "EcsTask-${var.cluster_name}-"

  assume_role_policy = data.aws_iam_policy_document.ecs_service_task_role_assume.json
}

data "aws_iam_policy_document" "ecs_service_task_role_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


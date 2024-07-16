output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_execution_role_name" {
  value = aws_iam_role.ecs_task_execution_role.name
}

output "ecs_task_execution_role_policy_arn" {
  value = aws_iam_role_policy_attachment.ecs_task_execution_role_policy.arn
}

output "ecs_task_execution_role_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.ecs_task_execution_role_policy.id
}

## CodeBuild Project

variable "name" {
  description = "The projects name."
}

variable "description" {
  description = "A short description of the project."  
}

variable "build_timeout" {
  description = "How long in minutes, for AWS CodeBuild to wait until timing out"
}

variable "artifacts" {
  description = "Information about the project's build output artifacts"
  type        = map(string)
}

variable "service_role_arn" {
  description = "IAM Role for CodeBuild"
}

variable "logs_config" {
  description = "Configuration for the builds to store log data to CloudWatch or S3"
  type        = any
}

variable "codebuild_source" {
  description = "Information about the project's input source code"
  type        = any
}

variable "vpc_config" {
  description = "Configuration for the builds to run inside a VPC"
  type        = map(string)
}

variable "environment" {
  description = "Information about the project's build"
  type        = any  
}

variable "common_tags" {
  description = "Common Resource Tags"
  type = map(string)
}
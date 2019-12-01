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
  type        = map(map(string))
}

variable "codebuild_source" {
  description = "Information about the project's input source code"
  type        = map(string)
}

variable "source_auth" {
  description = "Information about the authorization settings for AWS CodeBuild to access the source code to be built."
  type        = map(string)
}

variable "vpc_config" {
  description = "Configuration for the builds to run inside a VPC"
  type        = map(string)
}

variable "compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = "The builder instance class"
}

variable "environment" {
  type = map(string)  
}

variable "environment_variable" {
  type = list(map(string))
}

# variable "environment" {}

variable "encrypt_ami" {
  default = true
}

# variable "kms_key_arn" {
#   description = "If Encrypt_ami set to true then you must pass in the arn of the key you wish to encrypt disk with."
#   default = "Default"
#   type = "string"
# }

variable "environment_build_image" {
  type        = string
  default     = "aws/codebuild/standard:3.0"
  description = "Docker image used by CodeBuild"
}

# variable "packer_build_subnet_ids" {
#   type        = "list"
#   description = "Public subnet where Packer build instacen should run."
# }

# variable "packer_file_location" {
#   type        = "string"
#   description = "The file path of the .json packer to build."
# }

# variable "packer_vars_file_location" {
#   type = "string"
#   default = ""
#   description = "The file path to where extra Packer vars can be referenced"
# }

# variable "project_name" {
#   type = "string"
#   description = "Name of the CodeBuild Project"
# }

# variable "source_repository_url" {
#   type        = "string"
#   description = "The source repository URL"
# }

# variable "vpc_id" {}

variable "common_tags" {
  type = map(string)
}


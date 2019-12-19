resource "aws_codebuild_project" "codebuild_project" {
  name          = "ami-builder"
  description   = "Managed by Terraform: AMI builder using Packer and Ansible."
  build_timeout = var.build_timeout
  service_role  = var.service_role_arn
  dynamic "artifacts" {
    for_each = [var.artifacts]
    content {
      artifact_identifier    = lookup(artifacts.value, "artifact_identifier", null)
      encryption_disabled    = lookup(artifacts.value, "encryption_disabled", null)
      location               = lookup(artifacts.value, "location", null)
      name                   = lookup(artifacts.value, "name", null)
      namespace_type         = lookup(artifacts.value, "namespace_type", null)
      override_artifact_name = lookup(artifacts.value, "override_artifact_name", null)
      packaging              = lookup(artifacts.value, "packaging", null)
      path                   = lookup(artifacts.value, "path", null)
      type                   = artifacts.value.type
    }
  }

  dynamic "environment" {
    for_each = [var.environment]
    content {
      compute_type                = lookup(environment.value, "compute_type")
      image                       = lookup(environment.value, "image")
      type                        = lookup(environment.value, "type")
      image_pull_credentials_type = lookup(environment.value, "image_pull_credentials_type", null)
      privileged_mode             = lookup(environment.value, "privileged_mode", false)

      dynamic "environment_variable" {
        for_each = lookup(environment.value, "environment_variable", []) == 0 ? [] : lookup(environment.value, "environment_variable", [])
        content {
          name  = lookup(environment_variable.value, "name", null)
          value = lookup(environment_variable.value, "value", null)
          type  = lookup(environment_variable.value, "type", null)
        }
      }
    }
  }

  dynamic "source" {
    for_each = [var.codebuild_source]
    content {
      buildspec           = lookup(source.value, "buildspec", null)
      git_clone_depth     = lookup(source.value, "git_clone_depth", null)
      insecure_ssl        = lookup(source.value, "insecure_ssl", null)
      location            = lookup(source.value, "location", null)
      report_build_status = lookup(source.value, "report_build_status", null)
      type                = source.value.type

      dynamic "auth" {
        for_each = length(keys(lookup(source.value, "auth", {}))) == 0 ? [] : [lookup(source.value, "auth", {})]
        content {
          resource = lookup(auth.value, "resource", null)
          type     = auth.value.type
        }
      }
    }
  }

  dynamic "logs_config" {
    for_each = length(keys(var.logs_config)) == 0 ? [] : [var.logs_config]
    content {
      dynamic "cloudwatch_logs" {
        for_each = length(keys(lookup(var.logs_config, "cloudwatch_logs", {}))) == 0 ? [] : [lookup(var.logs_config, "cloudwatch_logs", {})]
        content {
          group_name  = lookup(cloudwatch_logs.value, "group_name", null)
          status      = lookup(cloudwatch_logs.value, "status", null)
          stream_name = lookup(cloudwatch_logs.value, "stream_name", null)
        }
      }

      dynamic "s3_logs" {
        for_each = length(keys(lookup(var.logs_config, "s3_logs", {}))) == 0 ? [] : [lookup(var.logs_config, "s3_logs", {})]
        content {
          encryption_disabled = lookup(s3_logs.value, "encryption_disabled", null)
          location            = lookup(s3_logs.value, "location", null)
          status              = lookup(s3_logs.value, "status", null)
        }
      }
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config == {} ? [var.vpc_config] : []
    content {
      security_group_ids = [vpc_config.value.security_group_ids]
      subnets            = vpc_config.value.subnets
      vpc_id             = vpc_config.value.vpc_id
    }
  }
}
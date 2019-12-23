# Terraform Module Name: terraform-module-aws-codebuild-poject


## General

This module may be used to create **_CodeBuild Project_** resources in AWS cloud provider..

---


## Prerequisites

This module needs Terraform 0.11.14 or newer.
You can download the latest Terraform version from [here](https://www.terraform.io/downloads.html).

This module deploys aws services details are in respective feature branches.

---

## Features Branches

Below we are able to check the resources that are being created as part of this module call:

From branch : **_terraform-12/master_**

* **_CodeBuild Project (Terraform 11 supported code)_**


---

## Below are the resources that are launched by this module

* **_CodeBuild Project_**


---

## Usage

## Using this repo

To use this module, add the following call to your code:

```tf
module "<layer>-codebuild-project-<AccountID>" {
  source = "git::https://github.com/nitinda/terraform-module-aws-codebuild-project.git?ref=terraform-12/master"

    providers = {
    aws = aws.services
  }

  build_timeout = 60
  artifacts     = {
    type = "NO_ARTIFACTS"
  }

  common_tags          = var.common_tags
  service_role_arn     = module.iam_role_code_build.arn
  source_auth          = local.codebuild_source_auth
  logs_config          = {
    s3_logs = {
      status = "DISABLED"
    }
    cloudwatch_logs = {
      status = "ENABLED"
    }
  }
  codebuild_source = {
      type                = "GITHUB"
      location            = "https://github.com/nitinda/packer-aws-ami-builder.git"
      buildspec           = data.template_file.template_file_ami_buildspec.rendered
      git_clone_depth     = 0
      report_build_status = true

      auth = {
        type     = "OAUTH"
        resource = module.codebuild_source_credentials.arn
      }
  }
  environment = {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:3.0"
    type         = "LINUX_CONTAINER"

    environment_variable = [
      {
        name  = "AMAZON_LINUX2_AMI"
        value = "AmazonLinux2"
      }
    ]
  }
  vpc_config           = local.vpc_config
}
```
---

## Inputs

The variables required in order for the module to be successfully called from the deployment repository are the following:

|**_Variable_** | **_Description_** | **_Type_** | **_Argument Status_** |
|:----|:----|-----:|:---:|
| **_name_** | The projects name | string | **_Required_** |
| **_description_** | A short description of the project | string | **_Required_** |
| **_build\_timeout_** | How long in minutes | number | **_Required_** |
| **_artifacts_** | Info about the project's build | map(string) | **_Required_** |
| **_service\_role\_arn_** | IAM Role for CodeBuild | string | **_Required_** |
| **_logs\_config_** | Config for the builds to store log  | map(map(string))  | **_Required_** |
| **_codebuild\_source_** | Info about the project's input | any | **_Required_** |
| **_vpc\_config_** | Configuration for the builds to run | map(string) | **_Required_** |
| **_environment_** | Info about the project's build | any | **_Required_** |
| **_tags_** | Key-value mapping of resource tags  | map(string) | **_Required_** |



## Outputs

* **_id_**
* **_arn_**



### Usage
In order for the variables to be accessed on module level please use the syntax below:

```tf
module.<module_name>.<output_variable_name>
```

If an output variable needs to be exposed on root level in order to be accessed through terraform state file follow the steps below:

- Include the syntax above in the network layer output terraform file.
- Add the code snippet below to the variables/global_variables file.

```tf
data "terraform_remote_state" "<module_name>" {
  backend = "s3"

  config {
    bucket = <bucket_name> (i.e. "s3-webstack-terraform-state")
    key    = <state_file_relative_path> (i.e. "env:/${terraform.workspace}/4_Networking/terraform.tfstate")
    region = <bucket_region> (i.e. "eu-central-1")
  }
}
```

- The output variable is able to be accessed through terraform state file using the syntax below:

```tf
"${data.terraform_remote_state.<module_name>.<output_variable_name>}"
```

## Authors
Module maintained by Module maintained by the - **_Nitin Das_**
terraform {
  required_version = ">= 1.5.6"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.91.0"
    }
  }
}

resource "snowflake_function" "this" {
  comment             = var.comment
  database            = var.database
  handler             = var.handler
  imports             = var.imports
  is_secure           = var.is_secure
  language            = var.language
  name                = var.name
  null_input_behavior = var.null_input_behavior
  packages            = var.packages
  return_behavior     = var.return_behavior
  return_type         = var.return_type
  runtime_version     = var.runtime_version
  schema              = var.schema
  statement           = var.statement
  target_path         = var.target_path
}
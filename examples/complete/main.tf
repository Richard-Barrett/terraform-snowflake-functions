terraform {
  required_version = ">= 1.5.6"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.90.0"
    }
  }
}

provider "snowflake" {}

module "my_javascript_function" {
  source = "../.." # Path to the root of the module

  database    = "my_database"
  schema      = "my_schema"
  name        = "my_javascript_function"
  return_type = "STRING"
  statement   = <<-EOF
    function my_javascript_function() {
        return 'Hello, World!';
    }
    EOF
  language    = "JAVASCRIPT"
}
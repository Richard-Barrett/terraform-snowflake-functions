<img align="right" width="60" height="60" src="images/terraform.png">

# terraform-snowflake-functions

Terraform Module for Managing Snowflake Functions

- snowflake_function

The terraform-snowflake-functions repository is a Terraform module designed to manage the creation and configuration of functions in Snowflake. Snowflake is a cloud-based data warehousing platform.

Here's a summary of what this module does:

1. `Function Creation`: This module allows you to create user-defined functions in Snowflake. You can specify the function's name, return type, and the actual function body (the code that gets executed when the function is called).
2. `Language Support`: The module supports creating functions written in JavaScript and a Python variant, as these are the languages supported by Snowflake for user-defined functions.
3. `Function Configuration`: You can configure various aspects of the function, such as whether it's a secure function, its null input behavior, return behavior, and the version of the JavaScript runtime to use.
4. `Database and Schema`: You can specify the database and schema where the function should be created.
5. `Argument Specification`: The module allows you to specify the arguments for the function, including their names and types.
6. `Import and Package Management`: You can specify additional JavaScript libraries to import and Snowflake packages to use in the function.

In summary, the terraform-snowflake-functions repository is a Terraform module for managing Snowflake functions. It provides a declarative way to create and configure functions in Snowflake, making it easier to version control and automate your Snowflake function deployments.

Example CICD with `BitBucket` and `Codefresh`:

![Image](./images/diagram.png)

## Notes

The Snowflake Terraform module for creating functions supports two languages for the function body:

1. JavaScript: You can write your function in JavaScript, which is fully supported by Snowflake. When using JavaScript, set the language argument to "JAVASCRIPT".

2. Python: Snowflake also supports a Python variant for user-defined functions. However, it's important to note that this is not a fully featured Python runtime. It's a Python-like syntax that gets transpiled to JavaScript under the hood. When using this Python variant, set the language argument to "PYTHON".

3. SQL: Snowflake also supports inline SQL for the Statement.

These are the languages supported by Snowflake for user-defined functions, and hence by this Terraform module. Other languages like Java, C#, etc., are not supported for writing user-defined functions in Snowflake.

## Usage

The following shows basica and advanced usages for this module.

### Basic Usage

The following is an example for `Python`:

```hcl
module "my_python_function" {
  source = "https://github.com/Richard-Barrett/terraform-snowflake-functions"
  version = "0.0.1"

  database = "my_database"
  schema = "my_schema"
  name = "my_python_function"
  return_type = "STRING"
  statement = <<-EOF
    def my_python_function():
        return 'Hello, World!'
    EOF
  language = "PYTHON"
}
```

GitHub Copilot
To use this module for a Python function in Snowflake, you would need to provide the necessary arguments to the module. Here's an example:

In this example, we're creating a Python function that returns the string 'Hello, World!'. The statement argument contains the Python code for the function. The language argument is set to 'PYTHON' to indicate that the function is written in Python.

Please replace the placeholders (my_database, my_schema, etc.) with your actual values. Also, ensure that the source argument points to the correct path of your module.

Note: The Snowflake Python language is only available in the Snowflake Scripting variant of JavaScript and is not a fully featured Python runtime. It is a Python-like syntax that gets transpiled to JavaScript.

The following is an example for `Javascript`:

```hcl
module "my_javascript_function" {
  source = "https://github.com/Richard-Barrett/terraform-snowflake-functions"
  version = "0.0.1"

  database = "my_database"
  schema = "my_schema"
  name = "my_javascript_function"
  return_type = "STRING"
  statement = <<-EOF
    function my_javascript_function() {
        return 'Hello, World!';
    }
    EOF
  language = "JAVASCRIPT"
}
```

In this example, we're creating a JavaScript function that returns the string 'Hello, World!'. The statement argument contains the JavaScript code for the function. The language argument is set to 'JAVASCRIPT' to indicate that the function is written in JavaScript.

Please replace the placeholders (my_database, my_schema, etc.) with your actual values. Also, ensure that the source argument points to the correct path of your module.

### Advanced Usage

The following is an advanced usage for the module specifying a file instead of inline code

```hcl
module "my_javascript_function" {
  source = "./modules/my_function"  # replace with the actual path to your module

  database = "my_database"
  schema = "my_schema"
  name = "my_javascript_function"
  return_type = "STRING"
  statement = file("${path.module}/my_javascript_function.js")
  language = "JAVASCRIPT"
}
```

In this example, the file function reads the contents of the my_javascript_function.js file in the same directory as the module. The ${path.module} interpolation is a built-in Terraform variable that gives the path of the module.

Please replace the placeholders (my_database, my_schema, etc.) with your actual values. Also, ensure that the source argument points to the correct path of your module, and that the file path in the file function points to your JavaScript file.

### All Inputs Plus Options

```hcl
module "my_advanced_function" {
  source = "./modules/my_function"  # replace with the actual path to your module

  database = "my_database"
  schema = "my_schema"
  name = "my_advanced_function"
  return_type = "STRING"
  statement = file("${path.module}/my_advanced_function.js")
  language = "JAVASCRIPT"
  is_secure = true
  comment = "This is my advanced function"
  handler = "myHandler"
  null_input_behavior = "CALLED_ON_NULL_INPUT"
  return_behavior = "IMMUTABLE"
  runtime_version = "1.0"
  target_path = "/path/to/target"
  arguments = [
    {
      name = "arg1"
      type = "STRING"
    },
    {
      name = "arg2"
      type = "NUMBER"
    }
  ]
  imports = ["import1", "import2"]
  packages = ["package1", "package2"]
}
```

In this example, we're creating a secure JavaScript function with a comment, a handler, specific null input behavior, return behavior, runtime version, target path, arguments, imports, and packages. The function statement is read from a file named my_advanced_function.js in the same directory as the module.

Please replace the placeholders (my_database, my_schema, etc.) with your actual values. Also, ensure that the source argument points to the correct path of your module, and that the file path in the file function points to your JavaScript file.

### Considerations

1. Language Support: Snowflake supports JavaScript and a Python variant for user-defined functions. Other languages like Java are not supported.
2. File Path: If you're reading the function statement from a file, ensure that the file path is correct. The ${path.module} interpolation can be used to reference files relative to the module's directory.
3. Function Arguments: The arguments variable should be a list of objects, each with a name and type attribute. If the function doesn't take any arguments, you can set arguments to an empty list.
4. Secure Functions: If is_secure is set to true, the function is a secure function. Secure functions don't reveal sensitive data and are suitable for user-defined functions that manipulate sensitive data.
5. Null Input Behavior: The null_input_behavior variable determines how the function behaves when called with null input. It can be set to CALLED_ON_NULL_INPUT (the function is called normally) or RETURNS_NULL_ON_NULL_INPUT (the function returns null).
6. Return Behavior: The return_behavior variable determines whether the function is IMMUTABLE (always returns the same result for the same input) or VOLATILE (can return different results for the same input).
7. Runtime Version: The runtime_version variable specifies the version of the JavaScript runtime to use for the function.
8. Imports and Packages: The imports and packages variables allow you to specify additional JavaScript libraries to import and Snowflake packages to use, respectively.
9. Terraform Version and Provider: Ensure that you're using a version of Terraform and the Snowflake provider that supports all the features you're using.
10. Idempotency: Terraform is designed to be idempotent, meaning running the same configuration multiple times should result in the same state. However, if your function statement includes randomness or depends on external state, it might not be idempotent.

Remember to always test your Terraform configurations in a safe environment before applying them to production.

## Overview

This Terraform module is designed to manage a Snowflake pipe and its associated permissions. 

A Snowflake pipe is a named object in Snowflake that defines a data stream from an external source. This module allows you to create such a pipe with various configurations like automatic ingestion of new files, notification channels, and a custom copy statement.

The module also manages the permissions for the Snowflake pipe. It grants specified privileges to specified roles. The module provides flexibility in terms of applying the grant to future pipes in the schema, allowing the roles to grant the privilege to other roles, and enabling the privilege to be granted to the roles multiple times.

In summary, this module provides a structured and reusable way to create and manage Snowflake pipes and their permissions in a Terraform configuration.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1.0 |
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | ~> 0.90.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_snowflake"></a> [snowflake](#provider\_snowflake) | ~> 0.90.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [snowflake_function.this](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comment"></a> [comment](#input\_comment) | The comment for the function | `string` | `""` | no |
| <a name="input_database"></a> [database](#input\_database) | The name of the database | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | The handler for the function | `string` | `""` | no |
| <a name="input_imports"></a> [imports](#input\_imports) | The imports for the function | `list(string)` | `[]` | no |
| <a name="input_is_secure"></a> [is\_secure](#input\_is\_secure) | The security status of the function | `bool` | `false` | no |
| <a name="input_language"></a> [language](#input\_language) | The language of the function | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the function | `string` | n/a | yes |
| <a name="input_null_input_behavior"></a> [null\_input\_behavior](#input\_null\_input\_behavior) | The null input behavior of the function | `string` | `""` | no |
| <a name="input_packages"></a> [packages](#input\_packages) | The packages for the function | `list(string)` | `[]` | no |
| <a name="input_return_behavior"></a> [return\_behavior](#input\_return\_behavior) | The return behavior of the function | `string` | `""` | no |
| <a name="input_return_type"></a> [return\_type](#input\_return\_type) | The return type of the function | `string` | n/a | yes |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | The runtime version of the function | `string` | `""` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | The name of the schema | `string` | n/a | yes |
| <a name="input_statement"></a> [statement](#input\_statement) | The statement of the function | `string` | n/a | yes |
| <a name="input_target_path"></a> [target\_path](#input\_target\_path) | The target path of the function | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_snowflake_function"></a> [snowflake\_function](#output\_snowflake\_function) | The Snowflake function |
| <a name="output_snowflake_function_name"></a> [snowflake\_function\_name](#output\_snowflake\_function\_name) | The name of the Snowflake function |
<!-- END_TF_DOCS -->

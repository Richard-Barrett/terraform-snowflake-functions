output "snowflake_function" {
  description = "The Snowflake function"
  value       = snowflake_function.this.id
}

output "snowflake_function_name" {
  description = "The name of the Snowflake function"
  value       = snowflake_function.this.name
}

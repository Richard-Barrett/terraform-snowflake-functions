variable "comment" {
  description = "The comment for the function"
  type        = string
  default     = ""
}

variable "database" {
  description = "The name of the database"
  type        = string
  validation {
    condition     = can(regex("[^|]*", var.database))
    error_message = "The database name must not contain a '|'."
  }
}

variable "handler" {
  description = "The handler for the function"
  type        = string
  default     = ""
}

variable "imports" {
  description = "The imports for the function"
  type        = list(string)
  default     = []
}

variable "is_secure" {
  description = "The security status of the function"
  type        = bool
  default     = false
}

variable "language" {
  description = "The language of the function"
  type        = string
}

variable "name" {
  description = "The name of the function"
  type        = string
  validation {
    condition     = can(regex("[^|]*", var.name))
    error_message = "The function name must not contain a '|'."
  }
}

variable "null_input_behavior" {
  description = "The null input behavior of the function"
  type        = string
  default     = ""
}

variable "packages" {
  description = "The packages for the function"
  type        = list(string)
  default     = []
}

variable "return_behavior" {
  description = "The return behavior of the function"
  type        = string
  default     = ""
}

variable "return_type" {
  description = "The return type of the function"
  type        = string
}

variable "runtime_version" {
  description = "The runtime version of the function"
  type        = string
  default     = ""
}

variable "schema" {
  description = "The name of the schema"
  type        = string
  validation {
    condition     = can(regex("[^|]*", var.schema))
    error_message = "The schema name must not contain a '|'."
  }
}

variable "statement" {
  description = "The statement of the function"
  type        = string
}

variable "target_path" {
  description = "The target path of the function"
  type        = string
  default     = ""
}
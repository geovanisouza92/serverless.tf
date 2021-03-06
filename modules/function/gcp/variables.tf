variable "name" {
  type        = "string"
  description = "Name of the function"
}

variable "bucket" {
  type        = "string"
  description = "Deployment bucket for the function"
}

variable "description" {
  type        = "string"
  default     = ""
  description = "Description of the function"
}

variable "handler" {
  type        = "string"
  description = "Handler of the function"
}

variable "runtime" {
  type        = "string"
  default     = "nodejs8.10"
  description = "Runtime of the function"
}

variable "memory_size" {
  type        = "string"
  default     = "128"
  description = "Memory size of the function"
}

variable "timeout" {
  type        = "string"
  default     = "3"
  description = "Timeout of the function"
}

variable "code_path" {
  type        = "string"
  description = "Path to function code"
}

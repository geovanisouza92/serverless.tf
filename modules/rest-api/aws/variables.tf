variable "name" {
  type        = "string"
  description = "Name"
}

variable "description" {
  type        = "string"
  default     = ""
  description = "Description"
}

variable "routes" {
  type        = "list"
  description = "Routes mapping"
}

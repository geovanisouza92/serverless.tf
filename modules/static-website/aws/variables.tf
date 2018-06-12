variable "hosting_domain" {
  type        = "string"
  default     = "serverless.com"
  description = "The domain name for the site like 'serverless.com'"
}

variable "alias_domain" {
  type        = "string"
  default     = "www.serverless.com"
  description = "The alias domain for the site like 'www.serverless.com'"
}

variable "content_path" {
  type        = "string"
  default     = "./site"
  description = "Relative path of a folder for the contents of the site like './site'"
}

variable "content_index" {
  type        = "string"
  default     = "index.html"
  description = "The index page for the site like 'index.html'"
}

variable "content_error" {
  type        = "string"
  default     = "error.html"
  description = "The error page for the site like 'error.html'"
}

variable "region" {
  type        = "string"
  default     = "us-east-1"
  description = "The AWS region where the site will be hosted like 'us-east-1'"
}

variable "name" {
  type        = "string"
  description = "Logical name of the site"
}

variable "template_values" {
  type        = "map"
  description = "templateValues"
}

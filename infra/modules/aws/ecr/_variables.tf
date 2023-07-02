variable "environment" {
  description = "Environment name"
  type        = string
}

variable "app_prefix" {
  description = "Common prefix for resource names"
  type        = string
}

variable "aws_region" {
  description = "Region specification for aws"
  type        = string
}

variable "extra_tags" {
  description = "Extra tags to be applied to the resource"
  type        = map(string)
  default     = {}
}

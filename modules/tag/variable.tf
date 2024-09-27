variable "costcenter" {
  description = "The name of the cost center."
  type        = string
  default     = "default"
}

variable "description" {
  description = "A description of the resource."
  type        = string
}

variable "environment" {
  description = "The environment of the resource."
  type        = string
  default     = ""
}

variable "owner" {
  description = "The team responsible for the resource."
  type        = string
}

variable "postfix" {
  description = "The postfix of the resource name. Set this variable to avoid name conflicts."
  type        = string
  default     = ""
}

variable "utilization" {
  description = "The utilization of the resource."
  type        = string
  default     = ""
}

variable "workload" {
  description = "The name of the AWS account or workload."
  type        = string
}

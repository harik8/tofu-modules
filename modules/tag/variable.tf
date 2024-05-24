variable "description" {
  description = "A description of the resource."
  type        = string
}

variable "environment" {
  description = "The environment where the resource will be created."
  type        = string
}

variable "name" {
  description = "Name of the resource."
  type        = string
}

variable "workload" {
  description = "Name of the workload."
  type        = string
}

variable "team" {
  description = "The team responsible for the resource."
  type        = string
}
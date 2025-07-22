variable "project_name" {}
variable "subnet_ids" {
  type = list(string)
}
variable "sg_id" {}
variable "vpc_id" {
  type = string
}
variable "vpc_id" {
  type        = string
  description = "The VPC ID for the ALB"
}

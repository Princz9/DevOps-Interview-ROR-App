variable "project_name" {}
variable "image_url" {}
variable "subnet_ids" {
  type = list(string)
}
variable "sg_id" {}
variable "region" {}
variable "execution_role_arn" {}
variable "db_host" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "bucket_name" {}
variable "target_group_arn" {}
variable "vpc_id" {
  description = "The VPC ID to associate with resources"
  type        = string
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
variable "project_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

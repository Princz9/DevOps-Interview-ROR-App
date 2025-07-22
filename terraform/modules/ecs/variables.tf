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

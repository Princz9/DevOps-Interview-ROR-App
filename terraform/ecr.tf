resource "aws_ecr_repository" "ror_app" {
  name                 = "ror-app-repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

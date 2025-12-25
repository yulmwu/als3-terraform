bucket         = "als3-terraform-state-bucket"
key            = "als3/dev/terraform.tfstate"
region         = "ap-northeast-2"
dynamodb_table = "TerraformStateLock"
encrypt        = true

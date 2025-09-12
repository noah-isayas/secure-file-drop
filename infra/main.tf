terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.92"

        }
    }

    backend "s3" {
        bucket = "sfd-backend"
        key    = "dev/terraform.state"
        region = "eu-central-1"
        dynamodb_table = "sfd-backend-lock"
    }
}


module "s3_uploads" {
    source = "./modules/s3-bucket"
    bucket_name = "sfd-prod-uploads"
    enable_lifecycle = false
}

module "s3_clean" {
    source = "./modules/s3-bucket"
    bucket_name = "sfd-prod-clean"
    enable_lifecycle = false
}

module "s3_infected" {
    source = "./modules/s3-bucket"
    bucket_name = "sfd-prod-infected"
    enable_lifecycle = true
  
}

module "lambda" {
    source = "./modules/lambda-fn"
    function_name = "sfd-hello"
    handler = "lambda_function.lambda_handler"
    runtime = "python3.12"
    filename = "../lambdas/hello.zip"
    environment = {}
}
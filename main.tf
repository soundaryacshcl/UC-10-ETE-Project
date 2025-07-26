module "vpc" {
  source = "./modules/vpc"
  
  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr          = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "iam" {
  source = "./modules/iam"
  
  project_name = var.project_name
  environment  = var.environment
}

module "ecr" {
  source = "./modules/ecr"
  
  project_name = var.project_name
  environment  = var.environment
}

module "alb" {
  source = "./modules/alb"
  
  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  security_groups = [module.vpc.alb_security_group_id]
}

module "ecs" {
  source = "./modules/ecs"
  
  project_name             = var.project_name
  environment              = var.environment
  vpc_id                   = module.vpc.vpc_id
  private_subnets          = module.vpc.private_subnets
  ecs_security_group_id    = module.vpc.ecs_security_group_id
  task_execution_role_arn  = module.iam.ecs_task_execution_role_arn
  task_role_arn           = module.iam.ecs_task_role_arn
  ecr_patient_repo_url    = module.ecr.patient_service_repository_url
  ecr_appointment_repo_url = module.ecr.appointment_service_repository_url
  target_group_arns       = module.alb.target_group_arns
  container_cpu           = var.container_cpu
  container_memory        = var.container_memory
  app_port               = var.app_port
  desired_capacity       = var.desired_capacity
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  
  project_name    = var.project_name
  environment     = var.environment
  ecs_cluster_name = module.ecs.cluster_name
}

module "cloudtrail" {
  source           = "./modules/cloudtrail"
  name             = "uc10-cloudtrail"
  s3_bucket_name   = "uc10-cloudtrail-logs"  # ✅ manually created bucket

  # If you are not sending logs to CloudWatch, pass empty strings
  cloudwatch_log_group_arn = ""
  cloudwatch_role_arn      = ""

  # If not using KMS, pass empty string
  kms_key_id = ""

  tags = {
    Environment = "production"
    Name        = "uc10-cloudtrail"
  }
}


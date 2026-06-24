module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "project-cluster"
  cluster_version = "1.30"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    terraform_user = {

      principal_arn = "arn:aws:iam::933428634359:user/Terraform-user"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {

    main = {

      desired_size = 3
      min_size     = 2
      max_size     = 4

      instance_types = ["t3.small"]

    }
  }
}
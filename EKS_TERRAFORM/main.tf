resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn = "arn:aws:iam::835370685428:role/monika-eks"  # Replace with your IAM role ARN

  vpc_config {
    subnet_ids         = ["subnet-02160107bcfbf413e", "subnet-0f05f9bb23a24c040"]  # Replace with your subnet IDs
    security_group_ids = ["sg-0616f99a222a23a75"]                         # Replace with your security group IDs
  }

  tags = {
    Environment = "Production"
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = "arn:aws:iam::835370685428:role/monika-eks"  # Replace with your IAM role ARN
  subnet_ids         = ["subnet-02160107bcfbf413e", "subnet-0f05f9bb23a24c040"]      # Replace with your subnet IDs

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  tags = {
    Environment = "Production"
  }
}

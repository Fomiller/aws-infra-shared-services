resource "aws_iam_role" "eks_cluster" {
  name               = "${local.namespace}EksCluster"
  assume_role_policy = data.aws_iam_policy_document.eks.json
}

resource "aws_iam_role" "eks_fargate_profile" {
  name               = "${local.namespace}EksFargateProfile"
  assume_role_policy = data.aws_iam_policy_document.eks_fargate_profile.json
}

resource "aws_iam_role" "eks_node_groups" {
  name               = "${local.namespace}EksNodesGroups"
  assume_role_policy = data.aws_iam_policy_document.eks_node_groups.json
}

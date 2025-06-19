resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
  name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  value = aws_iam_role.lb_controller.arn
 }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-security-groups"
    value = aws_security_group.eks_ingress.id
  }

  # Ensure the IAM role is created before the Helm release
  depends_on = [
    aws_iam_role.lb_controller,
    aws_iam_role_policy_attachment.lb_controller_managed
  ]
}

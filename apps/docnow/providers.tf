provider "aws" {
  region = "${local.region}"
}

provider "kubernetes" {
  cluster_ca_certificate = "${base64decode(module.eks.cluster_certificate_authority_data)}"
  host                   = "${module.eks.cluster_endpoint}"
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["token", "-i", "${module.eks.cluster_id}"]
    command     = "aws-iam-authenticator"
  }
}

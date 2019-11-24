## k8s_eks_poc

kubernetes proof of concept umd-mith docnow

We will create the docnow app on AWS's managed Kubernetes Platform (other's to
follow) using terraform.

### Pre-requisites

***Use of this tool will cost you money. Please remember to destroy your
environment with a `terraform destroy` when you are done.***

The cost of keeping an unmodified version of this repo running for a day was approximately $10
as configured.

* [Terraform](https://www.terraform.io/)
* [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
* [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

### Configure Profile

Create an [IAM Admin User and
Group](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html).
We will be using the access id and secret key

Configure our credential with the [Instructions
here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration).
Terraform will be using the default AWS profile configured.

```bash
aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

### Install your Docnow App

These steps will create hardware inside your AWS Account.

```bash
terraform init
terraform plan
terraform apply
```

The apply step will need you to approve the creation. The process takes about 15
minutes and at the end will point to your AWS loadbalancer name.

When you are done collecting your tweets. Run the most important cost saving
command

```bash
terrafom destroy
```

The :point_up: will require you to approve the destruction of your
infrastructure. This also takes close to 15 minutes.

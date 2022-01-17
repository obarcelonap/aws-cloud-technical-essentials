# aws-cloud-technical-essentials

Contains exercises from coursera's course [AWS Cloud Technical Essentials](https://www.coursera.org/learn/aws-cloud-technical-essentials)

## Infra
Infrastructure is managed using [Terraform's AWS provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs),
all the related code is under `infra` root folder.

The first time terraform has to be initialized using the following command
```bash
aws-cloud-technical-essentials/infra/env
$ terraform init
```
On every infrastructure modification changes can be applied with the following command
```bash
aws-cloud-technical-essentials/infra/env
$ terraform apply
```

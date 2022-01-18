# aws-cloud-technical-essentials

Contains exercises from coursera's course [AWS Cloud Technical Essentials](https://www.coursera.org/learn/aws-cloud-technical-essentials)

## Infra
Infrastructure is managed using [Terraform's AWS provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs),
all the related code is under `infra` root folder.

The first time terraform has to be initialized using the following command
```shell
aws-cloud-technical-essentials/infra/env
$ terraform init
```
On every infrastructure modification changes can be applied with the following command
```shell
aws-cloud-technical-essentials/infra/env
$ terraform apply
```

## Tips

Default VPC not created for the region:
```shell
aws --region <REGION> ec2 create-default-vpc
```
If your account does not have default VPC you might need to reach out Amazon. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-migrate.html
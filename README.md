# lawandorga-main-infrastructure

This repository contains the main infrastructure for the Law&Orga project.
To get it working you should edit the `~/.aws/credentials` file and add the following lines:

```
[lawandorga]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```

Furthermore add a `terraform.tfvars` file in every folder with the following content:
```
scw_access_key="YOUR_ACCESS_KEY"
scw_secret_key="YOUR_SECRET_KEY"
scw_project_id="PROJECT_ID"
```

The keys can be generated in the Scaleway UI.

To deploy the infrastructure you should run the following command:
```
terraform apply
```

Please do not run `terraform destroy` as the whole infrastructure will break. 

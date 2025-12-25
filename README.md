```shell
cp env/dev.tfvars.example env/dev.tfvars

# if you need prod and staging environments, uncomment the lines below
# cp env/prod.tfvars.example env/prod.tfvars
# cp env/staging.tfvars.example env/staging.tfvars

terraform init
terraform apply -var-file="env/dev.tfvars"
```

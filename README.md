```shell
cp env/dev.tfvars.example env/dev.tfvars

# if you need prod and staging environments, uncomment the lines below
# cp env/prod.tfvars.example env/prod.tfvars
# cp env/staging.tfvars.example env/staging.tfvars

terraform init
terraform apply -var-file="env/dev.tfvars"
```

For detailed options(variables), see [`env/dev.tfvars.example`](env/dev.tfvars.example). 

If you have received an ACM SSL certificate for HTTPS communication, set `certificate_arn`. Setting `certificate_arn` adds HTTPS listeners, security group rules, and redirect actions to the ALBs.

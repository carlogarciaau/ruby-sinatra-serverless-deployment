init:
	@terraform init

test:
	@cd ..; terraform fmt -check
	@terraform fmt -check
	@terraform validate

plan:
	@terraform plan -var-file=../common.tfvars

apply: test plan
	@terraform apply -var-file=../common.tfvars

destroy:
	@terraform destroy -var-file=../common.tfvars

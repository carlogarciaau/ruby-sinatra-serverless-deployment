init:
	@terraform init

test:
	@cd ..; terraform fmt -check
	@terraform fmt -check
	@terraform validate

plan: test
	@terraform plan -var-file=../common.tfvars

apply:
	@terraform apply -var-file=../common.tfvars

destroy:
	@terraform destroy -var-file=../common.tfvars

SHELL:=/bin/bash
include .env

EXAMPLE=$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
VERSION=$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: all clean validate test diagram docs format release

all: test docs format

clean:
	rm -rf .terraform/

validate:
	$(TERRAFORM) init -upgrade && $(TERRAFORM) validate && \
		$(TERRAFORM) -chdir=modules/private init -upgrade && $(TERRAFORM) -chdir=modules/private validate && \
		$(TERRAFORM) -chdir=modules/public init -upgrade && $(TERRAFORM) -chdir=modules/public validate

test: validate
	$(CHECKOV) -d /work
	$(TFSEC) /work

diagram:
	$(DIAGRAMS) diagram.py

docs: diagram
	$(TERRAFORM_DOCS) markdown ./ >./README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/private >./modules/private/README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/public >./modules/public/README.md

format:
	$(TERRAFORM) fmt -list=true ./ && \
		$(TERRAFORM) fmt -list=true ./modules/private && \
		$(TERRAFORM) fmt -list=true ./modules/public

example:
	$(TERRAFORM) -chdir=examples/$(EXAMPLE) init -upgrade && $(TERRAFORM) -chdir=examples/$(EXAMPLE) plan -input=false

release: test
	git tag $(VERSION) && git push --tags

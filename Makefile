SHELL:=/bin/bash
include .env

EXAMPLE=$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: all clean validate test docs format

all: validate test docs format

clean:
	rm -rf .terraform/

validate:
	$(TERRAFORM) init && $(TERRAFORM) validate && \
		$(TERRAFORM) -chdir=modules/private init && $(TERRAFORM) -chdir=modules/private validate && \
		$(TERRAFORM) -chdir=modules/public init && $(TERRAFORM) -chdir=modules/public validate

test: validate
	$(CHECKOV) -d /work

	$(TFSEC) /work

diagram:
	$(DIAGRAMS) diagram.py

docs: diagram
	$(TERRAFORM_DOCS) markdown ./ >./README.md

format:
	$(TERRAFORM) fmt -list=true ./ && \
		$(TERRAFORM) fmt -list=true ./modules/private && \
		$(TERRAFORM) fmt -list=true ./modules/public

example:
	$(TERRAFORM) -chdir=examples/$(EXAMPLE) init && $(TERRAFORM) -chdir=examples/$(EXAMPLE) plan -input=false
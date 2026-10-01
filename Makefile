SHELL := /usr/bin/env bash

.PHONY: help check-tools fmt validate

help: ## Show available targets
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  %-18s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

check-tools: ## Show which core local tools are installed
	@for tool in git ssh tofu ansible kubectl helm; do \
		if command -v $$tool >/dev/null 2>&1; then \
			printf "OK      %s\n" "$$tool"; \
		else \
			printf "MISSING %s\n" "$$tool"; \
		fi; \
	done

fmt: ## Format OpenTofu code when infrastructure exists
	@if [ -d infrastructure/opentofu ]; then tofu fmt -recursive infrastructure/opentofu; else echo "OpenTofu code not created yet."; fi

validate: ## Validate OpenTofu configuration when initialized
	@if [ -d infrastructure/opentofu ]; then tofu -chdir=infrastructure/opentofu validate; else echo "OpenTofu code not created yet."; fi

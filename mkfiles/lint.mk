.PHONY: lint
lint: lint-shell lint-gha

.PHONY: lint-shell
lint-shell:
	@find . -type f -name "*.sh" -o -name "*.sh.tmpl" | \
		grep -Ev '(\.venv|spec)' | \
		xargs -I{} bash -c 'echo {}; \
		if [[ "{}" =~ \.tmpl ]]; then \
			chezmoi execute-template < {} | shellcheck --severity=error -; \
		else \
			shellcheck --severity=error {}; \
		fi'

.PHONY: lint-gha
lint-gha:
	ghalint run && \
		find .github/actions -type f -name "action.yaml" -o -name "action.yml" | \
		xargs -I{} ghalint run-action {}

.PHONY: prettier
prettier:
	@npx prettier --write ./

.PHONY: pre-commit-all
pre-commit-all:
	@pre-commit run --all-files

.PHONY: super-linter
super-linter: SUPERLINTER_IMAGE ?= ghcr.io/super-linter/super-linter:slim-v7
super-linter:
	@docker pull $(SUPERLINTER_IMAGE); \
	ARGS=""; \
	if [[ -z "$$GITHUB_ACTION" ]]; then \
		ARGS="-e RUN_LOCAL=true -e VALIDATE_ALL_CODEBASE=true"; \
	fi; \
	docker run --rm \
		--env-file .superlinterenv \
		-e TZ="$${TZ:-Asia/Tokyo}" \
		$${ARGS} \
		-v $$(pwd):/tmp/lint \
		$(SUPERLINTER_IMAGE) 2>&1 | tee superlinter.log

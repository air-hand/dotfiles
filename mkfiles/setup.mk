.PHONY: setup
setup:
	@aqua i && \
		mise trust .mise.toml && mise install && eval "$$(mise hook-env -s bash)" && \
		poetry install --no-root && \
		echo $$(pwd) && command -v git && ls -lha .git && \
		pre-commit install || cat $$HOME/.cache/pre-commit/pre-commit.log

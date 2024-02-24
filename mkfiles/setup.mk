.PHONY: setup
setup:
	@aqua i && \
		mise trust .mise.toml && \
		mise settings set experimental true && \
		mise settings set python_venv_auto_create true && \
		mise settings set python_compile true && \
		mise install && eval "$$(mise hook-env -s bash)" && \
		poetry install --no-root && \
		pre-commit install || cat $$HOME/.cache/pre-commit/pre-commit.log

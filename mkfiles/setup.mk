POETRY := mise exec -- poetry
PRE_COMMIT := mise exec -- pre-commit

.PHONY: setup
setup:
	@aqua i && \
		mise trust .mise.toml && \
		mise settings set experimental true && \
		mise settings set python_venv_auto_create true && \
		mise settings set python_compile true && \
		mise install && \
		$(POETRY) install --no-root && \
		$(PRE_COMMIT) install || cat $$HOME/.cache/pre-commit/pre-commit.log

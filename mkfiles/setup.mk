PRE_COMMIT := mise exec -- pre-commit

.PHONY: setup
setup:
	@aqua i && \
		mise trust .mise.toml && \
		mise settings set experimental true && \
		mise settings set python.compile true && \
		mise install && \
		$(PRE_COMMIT) install || cat $$HOME/.cache/pre-commit/pre-commit.log

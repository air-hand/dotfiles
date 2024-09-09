MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

VSCODE_PATH := $(MAKEFILE_DIR)/vscode

SHELL := /bin/bash

.DEFAULT := all

MAKE := make --no-print-directory

.PHONY: all
all: apply

.PHONY: apply
apply:
	chezmoi apply

.PHONY: watch
watch:
	/bin/bash -i -c 'EXCLUDE=1 watch_cmd "\.git\/" "$(MAKE) apply"'

.PHONY: copy_from_current
copy_from_current:
	@VSCODE_USER_SPACE=$$(wslpath "$$(wslvar APPDATA)/Code/User") \
	&& test -f "$${VSCODE_USER_SPACE}/keybindings.json" && \
		cp  "$${VSCODE_USER_SPACE}/keybindings.json" $(VSCODE_PATH)/keybindings.json || true

.PHONY: clean
clean:
	@rm -rf coverage

.PHONY: test
test: clean
	@shellspec -s bash

.PHONY: watch-test
watch-test:
	/bin/bash -i -c 'watch_cmd "\.sh" "$(MAKE) test"'

.PHONY: renovate
renovate: export GH_TOKEN ?=
renovate: LOG_LEVEL ?= info
renovate:
#	LOG_LEVEL=$(LOG_LEVEL) npx renovate --platform=local --token=$$(gh auth token)
	CURRENT_REPO=$$(gh repo view --json 'nameWithOwner' --jq '.nameWithOwner') && \
	LOG_LEVEL=$(LOG_LEVEL) RENOVATE_CONFIG_FILE=./renovate.json5 RENOVATE_BASE_BRANCHES=$$(git branch --show-current) npx renovate $${CURRENT_REPO} --dry-run --token=${GH_TOKEN} --require-config=ignored --schedule=

include $(MAKEFILE_DIR)mkfiles/*.mk

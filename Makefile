MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

VSCODE_PATH := $(MAKEFILE_DIR)/vscode

.DEFAULT := all

MAKE := make --no-print-directory

all: apply post-setup

.PHONY: apply
apply:
	chezmoi apply

.PHONY: post-setup
post-setup:
	pre-commit install

.PHONY: watch
watch:
	/bin/bash -i -c 'EXCLUDE=1 watch_cmd "\.git\/" "$(MAKE) apply"'

.PHONY: copy_from_current
copy_from_current:
	@VSCODE_USER_SPACE=$$(wslpath "$$(wslvar APPDATA)/Code/User") \
	&& test -f "$${VSCODE_USER_SPACE}/keybindings.json" && \
		cp  "$${VSCODE_USER_SPACE}/keybindings.json" $(VSCODE_PATH)/keybindings.json || true

.PHONY: test
test:
	@shellspec -s bash


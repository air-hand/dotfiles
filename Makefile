MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

VSCODE_PATH := $(MAKEFILE_DIR)/vscode

.PHONY: copy_from_current
copy_from_current:
	@VSCODE_USER_SPACE=$$(wslpath "$$(wslvar APPDATA)/Code/User") \
	&& test -f "$${VSCODE_USER_SPACE}/keybindings.json" && \
		cp  "$${VSCODE_USER_SPACE}/keybindings.json" $(VSCODE_PATH)/keybindings.json || true

# Dotfiles

## How to enable dotfiles?

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

## How to use for DevContainer?

Command Pallete -> Open Settings -> dotfiles

```json
dotfiles.repository: "OWNER/dotfiles",
dotfiles.installCommand: "~/dotfiles/path-to-installer.sh",
```

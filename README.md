# Dotfiles

## How to enable dotfiles?

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

## How to use for DevContainer?

Command Palette -> Open Settings -> dotfiles

```json
dotfiles.repository: "OWNER/dotfiles",
dotfiles.installCommand: "~/dotfiles/path-to-installer.sh",
```

## How to apply changes?

```sh
make
```

This runs `chezmoi apply` to sync dotfiles.

### How to update an expired GPG key

1. Download the GPG private key from your backup.
1. `gpg --import /path/to/downloaded_gpg_private_key`
1. Check the subkey with `gpg --list-secret-keys --keyid-format LONG`.
1. `gpg --edit-key --expert {SEC_FINGERPRINT}`
1. Select the target key with `gpg> key {SUBKEY_KEYID}`.
1. Run `gpg> expire`, then enter a new expiration date.
1. Enter the passphrase.
1. `gpg> save`
1. For security, delete the master private key.
    1. `gpg --export-secret-subkeys {FINGERPRINT} > /path/to/exported-subkeys-only.gpg`
    1. `gpg --delete-secret-keys {FINGERPRINT}`
    1. `gpg --import /path/to/exported-subkeys-only.gpg`
    1. Check with `gpg --list-secret-keys --keyid-format LONG {FINGERPRINT}`

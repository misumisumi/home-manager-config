# Sumi-Sumi's home-manager Configuration.

This is dotfiles managed with [home-manager](https://github.com/nix-community/home-manager).

## Usage

```
# core config (Please see apps/core)
home-manager switch --flake ".#core"

# small config (Please see apps/small, Include `core`)
home-manager switch --flake ".#small"

# full config (Please see apps/full, Include `core` and `small`)
home-manager switch --flake ".#full"
```

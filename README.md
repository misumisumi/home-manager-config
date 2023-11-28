# Sumi-Sumi's home-manager Configuration.

This is dotfiles managed with [home-manager](https://github.com/nix-community/home-manager).

## Usage

```
# minimal config (Please see apps/minimal)
home-manager switch --flake ".#minimal"

# core config (Please see apps/core, Include `minimal`)
home-manager switch --flake ".#core"

# core config (Please see apps/full, Include `minimal` and `core`)
home-manager switch --flake ".#full"
```

# Sumi-Sumi's home-manager Configuration.

This is dotfiles managed with [home-manager](https://github.com/nix-community/home-manager).

Please refer to the following directory for installed packages and settings.

```
└── apps
   ├── core     # Minimal configuration of CUI environment
   ├── full     # Desktop environment
   ├── medium   # Configuring LaTeX
   └── small    # Configuring neovim and zsh
```

## Usage

```
# core config (Please see apps/core)
home-manager switch --flake ".#core"

# small config (Please see apps/small, Include `core`)
home-manager switch --flake ".#small"

# full config (Please see apps/full, Include `core` and `small`)
home-manager switch --flake ".#full"
```

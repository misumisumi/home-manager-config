# Sumi-Sumi's home-manager Configuration.

> This repository is archived!  
> All user environment settings have been integrated into [misumisumi/nixos-desktop-config](https://github.com/misumisumi/nixos-desktop-config).  
> see more details [misumisumi/nixos-desktop-config/issue#511](https://github.com/misumisumi/nixos-desktop-config/issues/51)

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

# Sumi-Sumi' NixOS & home-manager Common Configuration Flake

This is a common setting for desktop and server.
Please see the following repository.

# Usage
```
{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flakes = {
      url = "github:misumisumi/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    flake-utils,
    nur,
    home-manager,
    flakes,
  }: {
    nixosModules = {
      for-nixos = import ./modules/for-nixos.nix;
      for-hm = import ./modules/for-hm.nix;
    };
  };
}

```

## Include Settings

- neovim settings is [here (misumisumi/nvimdots)]()

```
```

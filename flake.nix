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
    nvimdots = {
      # url = "github:misumisumi/nvimdots";
      url = "github:misumisumi/nvimdots";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flakes.follows = "flakes";
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
    nvimdots,
  }: {
    nixosModules = {
      for-nixos = import ./modules/for-nixos.nix;
      for-hm = import ./modules/for-hm.nix;
    };
  };
}

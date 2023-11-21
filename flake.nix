{
  description = "My home-manager config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvimdots.url = "github:misumisumi/nvimdots";
    flakes.url = "github:misumisumi/flakes";
    private-config = {
      url = "git+ssh://git@github.com/misumisumi/nixos-private-config.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, flake-parts, ... }:
    let
      stateVersion = "23.11";
      overlay =
        { system }:
        let
          nixpkgs-stable = import inputs.nixpkgs-stable {
            inherit system;
            config = { allowUnfree = true; };
          };
        in
        {
          nixpkgs.overlays =
            [
              inputs.nur.overlay
              inputs.nixgl.overlay
              inputs.nix-matlab.overlay
              inputs.git-agecrypt.overlays.default
              inputs.flakes.overlays.default
              inputs.private-config.overlays.default
            ]
            ++ (import ./patches { inherit nixpkgs-stable; });
        };
    in
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        imports = [
          inputs.devshell.flakeModule
        ];
        flake = {
          homeManagerModules = {
            dotfiles = import ./modules/home-manager.nix;
            default = self.dotfiles;
          };
          homeConfigurations = import ./hosts {
            inherit (inputs.nixpkgs) lib;
            inherit inputs overlay stateVersion;
          };
        };
        systems = [ "x86_64-linux" ];
        perSystem = { config, pkgs, system, ... }: rec{
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              # inputs.nvfetcher.overlays.default
            ];
            config.allowUnfree = true;
          };
          devshells.default = {
            packages = with pkgs; [
              age
              sops
              ssh-to-age
            ];
          };
        };
      };
}

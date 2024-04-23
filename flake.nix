{
  description = "My home-manager config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flakes.url = "github:misumisumi/flakes";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nvimdots.url = "github:misumisumi/nvimdots";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs-stable";
      };
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, flake-parts, ... }:
    let
      stateVersion = "23.11";
    in
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        imports = [
          inputs.devshell.flakeModule
        ];
        flake = {
          homeManagerModules = {
            dotfiles = import ./modules/dotfiles.nix;
            default = self.dotfiles;
          };
          homeConfigurations = import ./hosts {
            inherit (inputs.nixpkgs) lib;
            inherit inputs stateVersion;
          };
          overlay = self.overlays.default;
          overlays.default =
            let
              nixpkgs-stable = import inputs.nixpkgs-stable {
                system = "x86_64-linux";
                config = { allowUnfree = true; };
              };
            in
            import ./patches { inherit nixpkgs-stable; };
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
            commands = [
              {
                help = "update keys of sops secrets";
                name = "update-keys";
                command = ''
                  find sops/secrets -type f | xargs -I{} sops updatekeys --yes {}
                '';
              }
            ];
            packages = with pkgs; [
              age
              bashInteractive
              home-manager
              sops
              ssh-to-age
            ];
          };
        };
      };
}

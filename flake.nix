{
  description = "My home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    nur.url = "github:nix-community/NUR";
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-agecrypt = {
      url = "github:vlaci/git-agecrypt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvimdots.url = "github:misumisumi/nvimdots";
    flakes.url = "github:misumisumi/flakes";
    private-config = {
      url = "git+ssh://git@github.com/misumisumi/nixos-private-config.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
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
    {
      nixosModules = {
        home-manager = import ./modules/home-manager.nix;
      };
      homeConfigurations = import ./hosts {
        inherit (inputs.nixpkgs) lib;
        inherit inputs overlay stateVersion;
      };
    };
}

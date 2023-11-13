{ inputs
, overlay
, stateVersion
, ...
}:
let
  settings =
    { hostname
    , user
    , system ? "x86_64-linux"
    , scheme ? ""
    , homeDirectory ? ""
    }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit hostname user stateVersion scheme homeDirectory; };
      modules = [
        (overlay { inherit system; })
        inputs.nur.nixosModules.nur

        inputs.flakes.nixosModules.for-hm
        inputs.nvimdots.nixosModules.nvimdots
        ../modules/${scheme}.nix
      ];
    };
in
{
  minimal = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "minimal";
  };
  core = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "core";
  };
  full = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "full";
  };
}

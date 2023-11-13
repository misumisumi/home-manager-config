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
  cui = settings {
    hostname = "cui";
    user = "hm-user";
    scheme = "minimal";
  };
}

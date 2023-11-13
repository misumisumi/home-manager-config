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
    , withExtra ? false
    , withGui ? false
    , homeDirectory ? ""
    }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (inputs.nixpkgs) lib;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit hostname user stateVersion withExtra withGui homeDirectory; };
      modules = [
        (overlay { inherit system; })
        inputs.nur.nixosModules.nur

        inputs.flakes.nixosModules.for-hm
        inputs.nvimdots.nixosModules.nvimdots
        ../modules/home-manager.nix
      ]; # ++ lib.optional withGui ./gui.nix;
    };
in
{
  cui = settings {
    hostname = "cui";
    user = "hm-user";
    withExtra = true;
  };
}

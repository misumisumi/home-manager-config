{ inputs
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
    , useNixOSWallpaper ? true
    , wm ? "none"
    }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs hostname user stateVersion scheme homeDirectory useNixOSWallpaper wm; };
      modules = [
        inputs.nur.nixosModules.nur
        inputs.sops-nix.homeManagerModules.sops
        inputs.spicetify-nix.homeManagerModule

        inputs.flakes.nixosModules.for-hm
        inputs.nvimdots.nixosModules.nvimdots
        ../modules/dotfiles.nix
        ./init/nix
        {
          dotfilesActivation = true;
          nix.package = pkgs.nix;
        }
      ];
    };
in
{
  core = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "core";
  };
  small = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "small";
  };
  medium = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "medium";
  };
  full = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "full";
  };
  test = settings {
    hostname = "liveimg";
    user = "hm-user";
    scheme = "full";
    wm = "qtile";
  };
}

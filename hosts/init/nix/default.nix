{ inputs, system, pkgs, ... }:
let
  nixpkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config = { allowUnfree = true; };
  };
in
{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs = {
    config = import ./nixpkgs-config.nix;
    overlays = [
      inputs.nur.overlay
      inputs.nixgl.overlay
      inputs.flakes.overlays.default
    ]
    ++ (import ../../../patches { inherit nixpkgs-stable; });
  };
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}

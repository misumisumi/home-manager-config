# From https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.home.installCommonPkgs;
in {
  options.home.installCommonPkgs = {
    enable = mkEnableOption "Install common packages";
    isLarge = mkEnableOption "Install all packages in pkgs/default.nix";
  };
  imports =
    [
      ./zinit.nix
    ]
    ++ (import ../apps);
  config = mkIf cfg.enable {
    home.packages = import ../pkgs/default.nix {
      inherit lib pkgs;
      inherit (cfg) isLarge;
    };
  };
}
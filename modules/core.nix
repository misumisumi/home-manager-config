# From https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
{ lib
, pkgs
, config
, ...
}:
with lib; let
  cfg = config.home.setupCore;
in
{
  options.home.setupCore.enable = mkEnableOption "Setup common packages";
  imports =
    [
      ./zinit.nix
      ./fzf
      ./git
      ./man
      ./ranger
    ]
    ++ (import ./shell);
  config = mkIf cfg.enable {
    home.packages = pkgs.callPacakges ../apps/pkgs;
  };
}

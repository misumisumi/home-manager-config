{ lib
, pkgs
, config
, ...
}:
with lib; let
  cfg = config.home.setupExtra;
in
{
  options.home.setupExtra.enable = mkEnableOption "Setup extra packages";
  imports =
    [
      ../apps/direnv
      ../apps/editorconfig
      ../apps/latexmk
      ../apps/navi
      ../apps/neovim
    ];
  config = mkIf cfg.enable {
    home.packages = pkgs.callPacakges ../apps/pkgs;
  };
}

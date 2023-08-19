# From https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
{ lib
, pkgs
, config
, ...
}:
with lib; let
  cfg = config.home.installCommonPkgs;
in
{
  options.home.installCommonPkgs = {
    enable = mkEnableOption "Install common packages";
    witExtra = mkEnableOption ''
      Setup `direnv`, `editorconfig`, `latexmk`, `navi`, `neovim`, `translate-shell` and some packages.
    '';
    withTmux = mkEnableOption ''
      Use `tmux` as multiplexer.
    '';
  };
  imports =
    [
      ./zinit.nix
    ]
    ++ (import ../apps {
      inherit lib; inherit (cfg) withExtra withTmux;
    });
  config = mkIf cfg.enable {
    home.packages = import ../apps/pkgs {
      inherit lib pkgs;
      inherit (cfg) withExtra;
    };
  };
}

{ pkgs
, config
, ...
}:
{
  imports = [
    ../apps/direnv
    ../apps/editorconfig
    ../apps/latexmk
    ../apps/navi
    ../apps/translate-shell
  ];
  config.home.packages = pkgs.callPackage (import ../apps/pkgs/extra.nix) { };
}

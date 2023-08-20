# From https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
{ lib
, pkgs
, config
, ...
}:
{
  imports =
    [
      ./zinit.nix
      ../apps/fzf
      ../apps/git
      ../apps/man
      ../apps/ranger
      ../apps/wezterm
    ] ++ (import ../apps/shell);
  config.home.packages = pkgs.callPackage (import ../apps/pkgs/core.nix) { };
}

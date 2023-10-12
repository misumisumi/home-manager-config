# From https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
{ pkgs
, ...
}:
{
  imports =
    [
      ../apps/fzf
      ../apps/git
      ../apps/man
      ../apps/ranger
      ../apps/wezterm
      ../apps/shell/bash.nix
      ../apps/shell/starship.nix
    ];
  config.home.packages = pkgs.callPackage (import ../apps/pkgs/core.nix) { };
}

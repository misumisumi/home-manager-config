{ config
, lib
, pkgs
, user
, stateVersion
, withExtra ? false
, homeDirectory ? ""
, ...
}: {
  imports =
    [
      ../apps/bash
      ../apps/btop
      ../apps/direnv
      ../apps/editorconfig
      ../apps/fzf
      ../apps/git
      ../apps/latexmk
      ../apps/man
      ../apps/navi
      ../apps/neovim
      ../apps/nix-conf
      ../apps/pkgs/core.nix
      ../apps/ranger
      ../apps/starship
      ../apps/tmux
      ../apps/translate-shell
      ../apps/wezterm
      ../apps/xdg
      ../apps/zsh
    ]
    ++ lib.optionals withExtra [
      ../apps/pkgs/extra.nix
      ../apps/texlive
    ];
  programs.home-manager.enable = true;

  home = {
    inherit stateVersion;
    username = "${user}";
    homeDirectory = if homeDirectory == "" then "/home/${user}" else homeDirectory;

    sessionVariables = {
      CHROME_PATH = "${pkgs.vivaldi}/bin/vivaldi";
      NIXOS_OZONE_WL = "1";
    };
  };
  fonts.fontconfig.enable = true;

}

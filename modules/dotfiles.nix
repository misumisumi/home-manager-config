{ config
, lib
, pkgs
, user
, hostname
, stateVersion
, scheme ? "small"
, wm ? ""
, homeDirectory ? ""
, ...
}:
{
  options = {
    dotfilesActivation = lib.mkEnableOption "Activate dotfiles";
  };
  imports = [
    ../apps/core/bash
    ../apps/core/btop
    ../apps/core/fzf
    ../apps/core/git
    ../apps/core/man
    ../apps/core/navi
    ../apps/core/pkgs
    ../apps/core/ranger
    ../apps/core/sops
    ../apps/core/ssh
    ../apps/core/starship
    ../apps/core/tmux
    ../apps/core/wezterm
    ../apps/core/xdg
  ] ++ lib.optional (builtins.pathExists ../users/${user}) ../users/${user}
  ++ lib.optional (builtins.pathExists ../hosts/${hostname}) ../hosts/${hostname}
  ++ lib.optionals (scheme != "core") [
    ../apps/small/direnv
    ../apps/small/editorconfig
    ../apps/small/neovim
    ../apps/small/pkgs
    ../apps/small/translate-shell
    ../apps/small/zsh
  ]
  ++ lib.optionals (scheme == "medium" || scheme == "full") [
    ../apps/medium/pkgs
    ../apps/medium/texlive
  ]
  ++ lib.optionals (scheme == "full") (
    [ ../apps/full/pkgs ] ++
      builtins.concatMap import [
        ../apps/full/ime
        ../apps/full/programs
        ../apps/full/services
        ../apps/full/systemd
        ../apps/full/terminal
        ../apps/full/theme
        ../apps/full/xdg-mime
      ]
  )
  ++ lib.optionals (builtins.pathExists ../apps/full/wm/${wm}) [
    ../apps/full/xsession
    ../apps/full/wm/${wm}
  ]
  ;
  config = lib.mkIf config.dotfilesActivation {
    programs.home-manager.enable = true;
    assertions = [
      {
        assertion = scheme == "core" || scheme == "small" || scheme == "medium" || scheme == "full";
        message = ''
          Set scheme 'core' or 'small' or 'full'.
          core: shell=bash, core utils, no editor, assuming diskless server
          small: shell=zsh, and neovim,
          medium: shell=zsh, daily use such as pandoc and texlive etc.., without GUI apps
          full: shell=zsh, daily use such as neovim and vivaldi, with GUI apps
        '';
      }
    ];
    home = {
      inherit stateVersion;
      username = "${user}";
      homeDirectory = if homeDirectory == "" then "/home/${user}" else homeDirectory;
    };
    fonts.fontconfig.enable = true;
  };
}

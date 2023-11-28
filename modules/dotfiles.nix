{ config
, lib
, pkgs
, user
, hostname
, stateVersion
, scheme ? "minimal"
, wm ? ""
, homeDirectory ? ""
, ...
}:
{
  options = {
    dotfilesActivation = lib.mkEnableOption "Activate dotfiles";
  };
  imports = [
    ../apps/minimal/bash
    ../apps/minimal/btop
    ../apps/minimal/fzf
    ../apps/minimal/git
    ../apps/minimal/man
    ../apps/minimal/navi
    ../apps/minimal/pkgs
    ../apps/minimal/ranger
    ../apps/minimal/sops
    ../apps/minimal/ssh
    ../apps/minimal/starship
    ../apps/minimal/tmux
    ../apps/minimal/wezterm
    ../apps/minimal/xdg
  ] ++ lib.optional (builtins.pathExists ../users/${user}) ../users/${user}
  ++ lib.optional (builtins.pathExists ../hosts/${hostname}) ../hosts/${hostname}
  ++ lib.optionals (scheme != "minimal") [
    ../apps/core/direnv
    ../apps/core/editorconfig
    ../apps/core/neovim
    ../apps/core/pkgs
    ../apps/core/texlive
    ../apps/core/translate-shell
    ../apps/core/zsh
  ] ++ lib.optionals (scheme == "full") (
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
  ) ++ lib.optionals (builtins.pathExists ../apps/full/wm/${wm}) [
    ../apps/full/xsession
    ../apps/full/wm/${wm}
  ]
  ;
  config = lib.mkIf config.dotfilesActivation {
    programs.home-manager.enable = true;
    assertions = [
      {
        assertion = scheme == "minimal" || scheme == "core" || scheme == "full";
        message = ''
          Set scheme 'minimal' or 'core' or 'full'.
          minimal: shell=bash, minimal utils, no editor, assuming diskless server
          core: shell=zsh, daily use such as neovim and texlive, without GUI apps
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

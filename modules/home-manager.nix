{ lib
, pkgs
, user
, stateVersion
, scheme ? "minimal"
, wm ? ""
, homeDirectory ? ""
, ...
}: {
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
  imports = [
    ../apps/cli/bash
    ../apps/cli/btop
    ../apps/cli/fzf
    ../apps/cli/git
    ../apps/cli/man
    ../apps/cli/navi
    ../apps/cli/nix-conf
    ../apps/cli/pkgs/minimal.nix
    ../apps/cli/ranger
    ../apps/cli/starship
    ../apps/cli/tmux
    ../apps/cli/wezterm
    ../apps/cli/xdg
  ] ++ lib.optionals (scheme != "minimal") [
    ../apps/cli/direnv
    ../apps/cli/editorconfig
    ../apps/cli/neovim
    ../apps/cli/pkgs/core.nix
    ../apps/cli/texlive
    ../apps/cli/translate-shell
    ../apps/cli/zsh
  ] ++ lib.optionals (scheme == "full") (
    [ ../apps/gui/pkgs ] ++
      builtins.concatMap import [
        ../apps/gui/ime
        ../apps/gui/programs
        ../apps/gui/services
        ../apps/gui/systemd
        ../apps/gui/terminal
        ../apps/gui/theme
        ../apps/gui/xdg-mime
      ]
  )
  ++ lib.optionals (wm != "") [
    ../apps/gui/wm/${wm}
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

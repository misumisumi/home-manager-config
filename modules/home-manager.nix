{ lib
, pkgs
, user
, stateVersion
, scheme ? "minimal"
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
    ../apps/cui/bash
    ../apps/cui/btop
    ../apps/cui/fzf
    ../apps/cui/git
    ../apps/cui/man
    ../apps/cui/navi
    ../apps/cui/nix-conf
    ../apps/cui/pkgs/minimal.nix
    ../apps/cui/ranger
    ../apps/cui/starship
    ../apps/cui/tmux
    ../apps/cui/wezterm
    ../apps/cui/xdg
  ] ++ lib.optionals (scheme != "minimal") [
    ../apps/cui/direnv
    ../apps/cui/editorconfig
    ../apps/cui/neovim
    ../apps/cui/pkgs/core.nix
    ../apps/cui/texlive
    ../apps/cui/translate-shell
    ../apps/cui/zsh
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

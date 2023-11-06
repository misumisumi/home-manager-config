{ config
, lib
, pkgs
, user
, stateVersion
, withExtra ? false
, ...
}: {
  imports =
    [
      ./zinit.nix
      ../apps/fzf
      ../apps/git
      ../apps/man
      ../apps/ranger
      ../apps/direnv
      ../apps/editorconfig
      ../apps/latexmk
      ../apps/navi
      ../apps/neovim
      ../apps/translate-shell
      ../apps/tmux
      ../apps/wezterm
    ] ++ (import ../apps/shell);
  programs.home-manager.enable = true;

  home = {
    inherit stateVersion;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage (import ../apps/pkgs/core.nix) { }
      ++ lib.optionals withExtra (pkgs.callPackage (import ../apps/pkgs/extra.nix) { });

    activation = {
      myActivationAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -d ${config.home.homeDirectory}/.config/ranger ]; then
          mkdir ${config.home.homeDirectory}/.config/ranger
        fi
      '';
    };

    sessionVariables = {
      CHROME_PATH = "${pkgs.vivaldi}/bin/vivaldi";
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    };

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      fgrep = "grep -F --color=auto";
      egrep = "grep -E --color=auto";
    } // lib.optionalAttrs withExtra {
      tm = "trash-put";
      tls = "trash-list";
      tre = "trash-restore";
      temp = "trash-empty";
      trm = "trash-rm";
      tty-clock = "tty-clock -s -c -C 6";
    };
  };
  fonts.fontconfig.enable = true;

  # xdg系のフォルダの作製
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_GAME_DIR = "${config.home.homeDirectory}/Game";
        XDG_WORKSPACE_DIR = "${config.home.homeDirectory}/workspace";
      };
    };
  };
}

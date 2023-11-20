/*
  Manage xsession from home-manager.
  NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
  However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{ config
, lib
, user
, pkgs
, useNixOSWallPaper ? true
, ...
}: {
  services = {
    screen-locker = {
      enable = true;
      inactiveInterval = 40;
      lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l -- -e";

      xautolock = {
        enable = true;
      };
    };
  };

  home = {
    packages = with pkgs; [ betterlockscreen libinput-gestures ];
    file = lib.optionalAttrs useNixOSWallPaper
      {
        "${config.home.homeDirectory}/Pictures/wallpapers/fixed/0_main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
        "${config.home.homeDirectory}/Pictures/wallpapers/fixed/1_main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
        "${config.home.homeDirectory}/Pictures/wallpapers/unfixed/main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
      } //
    lib.optionalAttrs (!useNixOSWallPaper) lib.mapAttrs'
      (f: _:
        lib.nameValuePair "${config.home.homeDirectory}/Pictures/wallpapers/${f}" {
          enable = true;
          source = ../wallpapers/${f};
        })
      (builtins.readDir ../wallpapers);
  };
  sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  keyboard = {
    layout = "us";
    model = "pc104";
    options = [ "ctrl:nocaps" ];
  };
  pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
    size = 32;
  };
};

xdg = {
configFile = {
"libinput-gestures.conf".source = ./libinput-gestures.conf;
};
};

xsession = {
enable = true;
preferStatusNotifierItems = true;

profileExtra = ''
      export GLFW_IM_MODULE=ibus
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
    '';
};

systemd.user.services = {
libinput-gestures = {
Unit = {
Description = "Launch libinput-gestures";
Partof = [ "graphical-session.target" ];
};
Service = {
Type = "simple";
ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
};
Install.WantedBy = [ "graphical-session.target" ];
};
};
}

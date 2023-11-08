{ lib
, pkgs
, withExtra ? false
, withTmux ? false
, ...
}:
{
  home.packages = with pkgs; [
    udev-gothic-nf
  ] ++ lib.optionals withExtra [
    (nerdfonts.override {
      # Nerdfont override
      fonts = [
        "FiraCode"
      ];
    })
  ];
  programs.wezterm = {
    enable = ! withTmux;
  };
  xdg = {
    configFile = lib.mapAttrs'
      (f: _:
        lib.nameValuePair "wezterm/${f}" {
          enable = ! withTmux;
          source = ./config/${f};
        })
      (builtins.readDir ./config);
  };
}

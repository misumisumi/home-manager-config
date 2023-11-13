{ lib
, pkgs
, scheme
, ...
}:
{
  home.packages = with pkgs; [
    udev-gothic-nf
  ] ++ lib.optionals (scheme != "minimal") [
    (nerdfonts.override {
      # Nerdfont override
      fonts = [
        "FiraCode"
      ];
    })
  ];
  programs.wezterm = {
    enable = true;
  };
  xdg = {
    configFile = lib.mapAttrs'
      (f: _:
        lib.nameValuePair "wezterm/${f}" {
          enable = true;
          source = ./wezterm/${f};
        })
      (builtins.readDir ./wezterm);
  };
}

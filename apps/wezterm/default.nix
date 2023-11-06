{ lib
, pkgs
, withExtra ? false
, ...
}:
{
  home.packages = with pkgs; [
    plemoljp-fonts # Install from misumisumi/flakes
  ] ++ lib.optionals withExtra [
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
    configFile = {
      "wezterm".source = ./config;
    };
  };
}

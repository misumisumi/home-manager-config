{ lib
, pkgs
, withExtra ? false
, withTmux ? false
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
    enable = ! withTmux;
  };
  xdg = {
    configFile = {
      "wezterm".source = if (! withTmux) then ./config else null;
    };
  };
}

{ pkgs, ... }:
{
  imports = [
    ../../apps/full/programs/firefox.nix
    ../../apps/full/programs/vivaldi.nix
  ];

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-gtk
          libsForQt5.fcitx5-qt
          fcitx5-mozc
          fcitx5-configtool
          fcitx5-nord
        ];
      };
    };
  };
}

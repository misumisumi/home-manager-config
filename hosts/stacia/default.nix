{ config, ... }:
{
  xresources = {
    extraConfig = "Xft.dpi:100";
  };
  sops.secrets = {
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../sops/secrets/ssh/univ;
      format = "binary";
    };
  };
}

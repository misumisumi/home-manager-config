{ config, ... }:
{
  sops.secrets = {
    "desktops" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/desktops";
      sopsFile = ../../sops/secrets/ssh/desktops;
      format = "binary";
    };
    "servers" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/servers";
      sopsFile = ../../sops/secrets/ssh/servers;
      format = "binary";
    };
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../sops/secrets/ssh/univ;
      format = "binary";
    };
  };
}

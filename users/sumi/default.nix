{ config, username, ... }:
{
  sops = {
    age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    age.keyFile = "${config.home.homeDirectory}/.age-key.txt";
    # secrets = {
    #   "secrets/common/ssh/conf.d/hosts/desktops" = {
    #     owner = "sumi";
    #     path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/desktops";
    #   };
    #   "secrets/common/ssh/conf.d/hosts/servers" = {
    #     owner = "sumi";
    #     path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/servers";
    #   };
    #   "secrets/common/ssh/conf.d/hosts/univ" = {
    #     owner = "sumi";
    #     path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
    #   };
    # };
  };
}

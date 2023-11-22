{ lib, config, ... }:
{
  systemd.user.startServices = "sd-switch";
  sops = {
    age = {
      sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      keyFile = "${config.home.homeDirectory}/.age-keys.txt";
    };
    secrets."ssh.lua" = {
      path = "${config.xdg.configHome}/wezterm/ssh.lua";
      sopsFile = ../../sops/secrets/wezterm/ssh.lua;
      format = "binary";
    };
  };
}

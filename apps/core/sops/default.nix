{ config
, lib
, pkgs
, ...
}:
{
  home.activation.ageActivatioinAction = lib.hm.dag.entryAfter [ "sshActivatioinAction" ] ''
    if [ ! -d ${config.xdg.configHome}/.config/sops/age ]; then
      ${pkgs.ssh-to-age}/bin/ssh-to-age -private-key -i ${config.home.homeDirectory}/.ssh/id_ed25519 > ${config.xdg.configHome}/sops/age/keys.txt
    fi
  '';
  sops = {
    age.generateKey = false;
  };
}

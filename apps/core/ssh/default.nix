{ config
, lib
, hostname
, pkgs
, ...
}:
{
  home.activation.sshActivatioinAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    [[ ! $(find ~/.ssh -type f | grep "ed25519") ]] && ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -C "$(whoami)@${hostname}-$(date -I)" -f ${config.home.homeDirectory}/.ssh/id_ed25519
    [[ ! $(find ~/.ssh -type f | grep "rsa") ]] && ${pkgs.openssh}/bin/ssh-keygen -t rsa -N "" -C "$(whoami)@${hostname}-$(date -I)" -f ${config.home.homeDirectory}/.ssh/id_rsa
  '';
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 30;
    serverAliveCountMax = 5;
    includes = [ "conf.d/hosts/*" ];
    matchBlocks = {
      "github" = {
        user = "git";
        hostname = "github.com";
      };
      "github.com" = {
        user = "git";
        hostname = "ssh.github.com";
        port = 443;
      };
    };
  };
}


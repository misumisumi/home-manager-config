{
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


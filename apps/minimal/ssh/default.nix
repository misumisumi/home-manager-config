{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 30;
    serverAliveCountMax = 5;
  };
}


{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyIgnore = ''
      "rm"
      "ls"
      "pkill"
      "kill"
      "history"
    '';
  };
}

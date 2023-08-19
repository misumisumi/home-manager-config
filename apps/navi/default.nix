{ pkgs, ... }:

{
  programs.navi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      style = {
        tag = {
          color = "cyan"; # text color. possible values = https =//bit.ly/3gloNNI
          width_percentage = 26; # column width relative to the terminal window
          min_width = 20; # minimum column width as number of characters
        };
        comment = {
          color = "blue";
          width_percentage = 42;
          min_width = 45;
        };
      };
      snippet = {
        color = "white";
      };
      finder = {
        command = "fzf"; # equivalent to the --finder option
      };
    };
  };
}
{ config, ... }:
{
  editorconfig = {
    enable = true;
  };
  home = {
    file."${config.home.homeDirectory}/.editorconfig".source = ./.editorconfig;
  };
}

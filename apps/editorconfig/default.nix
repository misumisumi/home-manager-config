{ config
, withExtra ? false
, ...
}:
{
  editorconfig = {
    enable = withExtra;
  };
  home = {
    file."${config.home.homeDirectory}/.editorconfig".source = if withExtra then ./.editorconfig else null;
  };
}

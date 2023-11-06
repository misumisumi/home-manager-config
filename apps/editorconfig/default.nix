{ config
, withExtra ? false
, ...
}:
{
  editorconfig = {
    enable = withExtra;
  };
  home = {
    file."${config.home.homeDirectory}/.editorconfig" = {
      enable = withExtra;
      source = ./.editorconfig;
    };
  };
}

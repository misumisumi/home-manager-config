{ withExtra ? false, ... }:
{
  xdg.configFile."latexmkrc" = {
    enable = withExtra;
    source = ./latexmkrc;
  };
}

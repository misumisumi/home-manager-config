{ withExtra ? false, ... }:
{
  xdg.configFile."latexmkrc".source = if withExtra then ./latexmkrc else null;
}

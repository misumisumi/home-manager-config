{ withExtra ? false, ... }:
{
  programs.translate-shell = {
    enable = withExtra;
    settings = {
      hl = "ja";
      tl = [
        "en"
      ];
    };
  };
}

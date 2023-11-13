{ pkgs, ... }:
{
  home.packages = with pkgs; [
    liberation_ttf # Font for Latex
    lmodern # Font for LaTex
    poppler_utils # A PDF rendering
  ];
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: {
      inherit (tpkgs)
        algorithms
        boondox
        collection-fontsrecommended
        collection-langjapanese
        collection-latexextra
        fontaxes
        latexmk
        newpx
        newtx
        newtxtt
        scheme-medium
        tlmgrbasics
        ;
    };
  };
}

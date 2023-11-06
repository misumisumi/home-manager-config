{
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

{ pkgs, ... }:
let
  texlive-combined = pkgs.texlive.combine {
    # TexLive(Japanese support)
    inherit
      (pkgs.texlive)
      scheme-medium
      latexmk
      collection-langjapanese
      collection-latexextra
      newtx
      newtxtt
      newpx
      boondox
      fontaxes
      tlmgrbasics
      ;
  };
in
with pkgs;[
  nixos-generators # creating nixos image tool
  github-cli # GitHub CLI tool
  graphicsmagick # CLI Image Editor
  liberation_ttf # Fonr for Latex
  lmodern # Font for LaTex
  pandoc # Document Converter
  playerctl # CLI control media
  poppler_utils # A PDF rendering
  sox # CLI Sound Editor
  texlive-combined # LaTex
]

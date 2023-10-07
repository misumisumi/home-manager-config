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
  nix-index # A files database for nixpkgs
  nix-prefetch # Prefetch checkers
  nix-prefetch-git
  nvfetcher # Tool of automate nix package updates

  ascii-image-converter # Make ascii art
  cloc # A program that counts lines of source code
  cmatrix # Lain of character
  convmv #convert encoding
  devbox # Instant, easy, predictable shells and container
  ffmpeg # Multi media solution
  figlet # Make AA from character
  github-cli # GitHub CLI tool
  graphicsmagick # CLI Image Editor
  liberation_ttf # Fonr for Latex
  lmodern # Font for LaTex
  nixos-generators # creating nixos image tool
  pandoc # Document Converter
  playerctl # CLI control media
  poppler_utils # A PDF rendering
  sox # CLI Sound Editor
  texlive-combined # LaTex
]
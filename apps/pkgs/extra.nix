{ pkgs, ... }:
let
  pythonPkgs = ps:
    with ps; [
      numpy
    ];
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
  (python3.withPackages pythonPkgs)

  nix-index # A files database for nixpkgs
  nix-prefetch # Prefetch checkers
  nix-prefetch-git
  nvfetcher # Tool of automate nix package updates
  nixos-generators # creating nixos image tool

  ascii-image-converter # Make ascii art
  cloc # A program that counts lines of source code
  cmatrix # Lain of character
  convmv #convert encoding
  ffmpeg # Multi media solution
  figlet # Make AA from character
  github-cli # GitHub CLI tool
  graphicsmagick # CLI Image Editor
  liberation_ttf # Fonr for Latex
  lmodern # Font for LaTex
  mosh # Mobile Shell
  nixos-generators # creating nixos image tool
  pandoc # Document Converter
  playerctl # CLI control media
  poppler_utils # A PDF rendering
  sox # CLI Sound Editor
  trash-cli # Command Line Interface to FreeDesktop.org Trash
  texlive-combined # LaTex
]

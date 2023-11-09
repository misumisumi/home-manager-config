{ lib
, pkgs
, ...
}:
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
  nix-index # A files database for nixpkgs
  nix-prefetch # Prefetch checkers
  nix-prefetch-git
  nvfetcher # Tool of automate nix package updates


  (python3.withPackages pythonPkgs)
  ascii-image-converter # Make ascii art
  cloc # A program that counts lines of source code
  cmatrix # Lain of character
  convmv #convert encoding
  ffmpeg # Multi media solution
  figlet # Make AA from character
  graphicsmagick # CLI Image Editor
  liberation_ttf # Font for Latex
  lmodern # Font for LaTex
  mosh # Mobile Shell
  pandoc # Document Converter
  playerctl # CLI control media
  poppler_utils # A PDF rendering
  sox # CLI Sound Editor
  texlive-combined # LaTex
  trash-cli # Command Line Interface to FreeDesktop.org Trash
  tty-clock # CLI clock
]

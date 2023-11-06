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
  cloc # A program that counts lines of source code
  ffmpeg # Multi media solution
  graphicsmagick # CLI Image Editor
  mosh # Mobile Shell
  sox # CLI Sound Editor
  trash-cli # Command Line Interface to FreeDesktop.org Trash
  tty-clock # CLI clock
] ++ lib.optionals (builtins.pathExists "/etc/NIXOS") [
  (python3.withPackages pythonPkgs)

  nix-index # A files database for nixpkgs
  nix-prefetch # Prefetch checkers
  nix-prefetch-git
  nvfetcher # Tool of automate nix package updates
  nixos-generators # creating nixos image tool

  ascii-image-converter # Make ascii art
  cmatrix # Lain of character
  convmv #convert encoding
  figlet # Make AA from character
  liberation_ttf # Font for Latex
  lmodern # Font for LaTex
  pandoc # Document Converter
  playerctl # CLI control media
  poppler_utils # A PDF rendering
  texlive-combined # LaTex
]

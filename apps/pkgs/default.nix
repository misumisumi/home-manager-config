{ lib
, pkgs
, withExtra ? false
}:
let
  pythonPkgs = ps:
    with ps; [
      numpy
    ];
in
with lib;
with pkgs;
[
  (python3.withPackages pythonPkgs)
  nix-index # A files database for nixpkgs
  nix-prefetch # Prefetch checkers
  nix-prefetch-git
  nvfetcher # Tool of automate nix package updates

  ascii-image-converter # Make ascii art
  bc # GNU calculater
  bintools # Manipulating binaries
  bottom # System monitor
  btop # System monitor
  cmatrix # Lain of character
  convmv #convert encoding
  devbox # Instant, easy, predictable shells and container
  dig # Domain name server
  duf # Show storage usage
  fd # fast find
  ffmpeg # Multi media solution
  figlet # Make AA from character
  iperf3 # Network speed test tool
  jq # JSON processor
  lsof # check port
  mosh # Mobile Shell
  neofetch # Fetch system info
  p7zip
  progress # Show progress of coreutils programs
  ripgrep # fast grep
  trash-cli # Command Line Interface to FreeDesktop.org Trash
  tree # Show file tree
  unzip
  zip # Archives
]
++ optionals withExtra (
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
  [
    nixos-generators # creating nixos image tool
    graphicsmagick # CLI Image Editor
    liberation_ttf # Fonr for Latex
    lmodern # Font for LaTex
    pandoc # Document Converter
    playerctl # CLI control media
    poppler_utils # A PDF rendering
    sox # CLI Sound Editor
    texlive-combined # LaTex
  ]
)

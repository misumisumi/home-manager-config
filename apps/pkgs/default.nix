{
  lib,
  pkgs,
  isLarge ? false,
}: let
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

      devbox # Instant, easy, predictable shells and container

      bc # GNU calculater

      zip # Archives
      unzip

      tree # Show file tree
      lsof # check port

      convmv #convert encoding
      jq # JSON processor

      bottom # System monitor
      btop # System monitor
      duf # Show storage usage
      neofetch # Fetch system info

      mosh # Mobile Shell

      trash-cli # Command Line Interface to FreeDesktop.org Trash
      ffmpeg # Multi media solution

      figlet # Make AA from character
      cmatrix # Lain of character
      ascii-image-converter # Make ascii art

      progress # Show progress of coreutils programs
      iperf3 # Network speed test tool
      bintools # Manipulating binaries

      fd # fast find
      ripgrep # fast grep
    ]
    ++ optionals isLarge (
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
      in [
        nixos-generators # creating nixos image tool
        graphicsmagick # CLI Image Editor
        pandoc # Document Converter
        playerctl # CLI control media
        sox # CLI Sound Editor
        texlive-combined # LaTex
        lmodern # Font for LaTex
        liberation_ttf # Fonr for Latex
      ]
    )
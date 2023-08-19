{ pkgs, ... }:
with pkgs;[
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

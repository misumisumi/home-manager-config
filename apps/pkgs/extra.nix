{ lib
, pkgs
, ...
}:
let
  pythonPkgs = ps:
    with ps; [
      numpy
    ];
in
{
  home.packages = with pkgs;[
    (python3.withPackages pythonPkgs)
    ascii-image-converter # Make ascii art
    cloc # A program that counts lines of source code
    cmatrix # Lain of character
    convmv #convert encoding
    ffmpeg # Multi media solution
    figlet # Make AA from character
    graphicsmagick # CLI Image Editor
    mosh # Mobile Shell
    pandoc # Document Converter
    playerctl # CLI control media
    sox # CLI Sound Editor
    tty-clock # CLI clock
  ];
}

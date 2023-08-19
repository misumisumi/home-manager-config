{ pkgs
}:
let
  pythonPkgs = ps:
    with ps; [
      numpy
    ];
in
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
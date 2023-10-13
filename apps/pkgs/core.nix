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

  bc # GNU calculater
  bintools # Manipulating binaries
  bottom # System monitor
  btop # System monitor
  dig # Domain name server
  duf # Show storage usage
  fd # fast find
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
  unzip #Archives
  yq-go # YAML processor
  zip # Archives
]

{ lib
, pkgs
, ...
}:
with pkgs;
[
  bottom # System monitor
  btop # System monitor
  duf # Show storage usage
  fd # fast find
  jq # JSON processor
  neofetch # Fetch system info
  progress # Show progress of coreutils programs
  ripgrep # fast grep
  tree # Show file tree
  unar # An archive unpacker program
  wget # Downloader
  yq-go # YAML processor

] ++ lib.optionals (builtins.pathExists "/etc/NIXOS") [
  bc # GNU calculater
  bintools # Manipulating binaries
  coreutils-full # GNU coreutils
  curl # Downloader
  dig # Domain name server
  gptfdisk # GPT partition tools
  iperf3 # Network speed test tool
  killall # Process killer
  lsof # check port
  traceroute # Track the network route
]

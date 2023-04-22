{
  imports =
    [
      ./zinit.nix
      ./nixosWallpaper.nix
    ]
    ++ (import ../apps);
}

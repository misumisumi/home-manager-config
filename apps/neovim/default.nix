# This is need `https://github.com/ayamir/nvimdots`
{ pkgs, ... }:
{
  programs.dotnet.dev.enable = true;
  programs.java.enable = true;
  programs.neovim.nvimdots = {
    enable = true;
    setBuildEnv = true;
    withBuildTools = true;
    withHaskell = true;
    extraDependentPackages = with pkgs; [ icu ];
  };
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      deno
      nixpkgs-fmt
      nixd
    ];
  };
}
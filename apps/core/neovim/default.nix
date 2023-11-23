# This is need `https://github.com/ayamir/nvimdots`
{ pkgs
, ...
}:
{
  home.sessionVariables.EDITOR = "nvim";
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
      go
      nixd
      nixpkgs-fmt
      statix
    ];
  };
}

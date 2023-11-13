# This is need `https://github.com/ayamir/nvimdots`
{ pkgs
, withExtra ? false
, ...
}:
{
  home.sessionVariables.EDITOR = "nvim";
  programs.dotnet.dev.enable = withExtra;
  programs.java.enable = withExtra;
  programs.neovim.nvimdots = {
    enable = withExtra;
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
    ];
  };
}

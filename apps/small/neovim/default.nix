# This is need `https://github.com/ayamir/nvimdots`
{ pkgs
, ...
}:
{
  home.sessionVariables.EDITOR = "nvim";
  programs = {
    dotnet.dev.enable = true;
    java.enable = true;
    neovim = {
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
      nvimdots = {
        enable = true;
        setBuildEnv = true;
        withBuildTools = true;
        withHaskell = true;
        extraDependentPackages = with pkgs; [ icu ];
      };
    };
  };
}

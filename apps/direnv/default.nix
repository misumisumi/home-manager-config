{ withExtra ? false, ... }:
{
  home.sessionVariables.DIRENV_WARN_TIMEOUT = "300s"; # DIRENVのタイムアウトまでを長くする
  programs = {
    direnv = {
      enable = withExtra;
      enableBashIntegration = true;
      enableZshIntegration = true;

      nix-direnv = {
        enable = true;
      };
    };
  };
}

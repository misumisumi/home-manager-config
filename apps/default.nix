{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.commonApps;
in {
  options = {
    commonApps = {
      enable = mkEnableOption ''
        Use common app configs
      '';
      loadApps = mkOption {
        type = types.listOf types.str;
        default = ["direnv" "fzf" "git" "man" "navi" "ranger" "shell"];
        example = ["git" "tmux"];
        description = ''
          List of loading modules.
          You can see available modules under "apps" dir.
        '';
        isLarge = mkEnableOption ''
          Install all apps in pkgs/default.nix
        '';
      };
    };
  };
  imports = [] ++ optionals cfg.enable (map (x: ./${x}) cfg.loadApps);
  config = mkIf cfg.enable {
    home.packges = (import ./apps/pkgs) {
      inherit lib pkgs;
      inherit (cfg) isLarge;
    };
  };
}

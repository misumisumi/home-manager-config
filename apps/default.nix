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

  config = mkIf cfg.enable (
    let
      mkImports = ls: f: fold (x: y: x // y) {} (f ls);
      mapImports = map (x: import ./${x});
    in
      {
        home.packges = (import ./apps/pkgs) {
          inherit lib pkgs;
          inherit (cfg) isLarge;
        };
      }
      // optionalAttrs cfg.enable mkImports mapImports cfg.loadApps
  );
}

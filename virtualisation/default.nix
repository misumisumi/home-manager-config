{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.virtualisation.commonApps;
  mkImports = mapped: fold (x: y: x // y) {} mapped;
  mapImports = map (x: import ./${x});
in {
  options.virtualisation = {
    commonApps = {
      enable = mkEnableOption ''
        Use common app configs
      '';
      loadApps = mkOption {
        type = types.listOf types.str;
        default = ["libvirt" "podman"];
        example = ["libvirt" "podman" "waydroid"];
        description = ''
          List of loading modules.
          Available modules is "libvirt", "podman", "waydroid"
        '';
      };
    };
  };
  config =
    mkIf cfg.enable {}
    // optionalAttrs (cfg.enable) (mkImports (mapImports cfg.loadApps));
}

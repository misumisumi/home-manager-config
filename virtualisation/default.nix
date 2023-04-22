{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.virtualisation.commonApps;
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
  config = mkIf cfg.enable (
    let
      mkImports = ls: f: fold (x: y: x // y) {} (f ls);
      mapImports = map (x: import ./${x});
    in
      mkImports mapImports cfg.loadApps
  );
}

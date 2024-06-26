# override: default.nixに記載の属性をオーバライドする
# overrideAttrs: default.nixに記載されていない属性も追加できる
# Package patch template
# (final: prev: {
#   package = prev.package.overrideAttrs (old: {
#   });
# })
# Unwrapped package patch template
# (final: prev: {
#   package = prev.package.unwrapped.override (old: {
#   });
# })
# pythonPackages patch template
# (final: prev: {
#   python3Packages = prev.python3Packages.override {
#     overrides = pfinal: pprev: {
#       package = pprev.package.overridePythonAttrs (old: {
#       });
#     };
#   };
# })
# haskellPackages patch template
# (final: prev: {
#   haskellPackages = prev.haskellPackages.override {
#     overrides = hself: hsuper: {
#       # Can add/override packages here
#       package = prev.haskell.lib.doJailbreak hsuper.package;
#     };
#   };
# })
# (final: prev: {
#   embree = pkgs-stable.embree;
#   openimagedenoise = pkgs-stable.openimagedenoise;
#   blender = pkgs-stable.blender;
#   spotify = pkgs-stable.spotify;
# })
# Patch from https://github.com/NixOS/nixpkgs/pull/211600
{ nixpkgs-stable, ... }:
final: prev: {
  pythonPackagesOverlays = (prev.pythonPackagesOverlays or [ ]) ++ [
    (pfinal: pprev: {
      qtile = pprev.qtile.overridePythonAttrs (old: {
        patches =
          old.patches
            ++ [
            ./fix-xcbq.patch
          ];
      }
      );
    }
    )
  ];
  ranger = prev.ranger.overridePythonAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "ranger";
      repo = "ranger";
      rev = "136416c7e2ecc27315fe2354ecadfe09202df7dd";
      sha256 = "09hvqnk8hvn2mv8m5w389q63wspyfksmwzkr7p8n70kfmfahlvlx";
    };
    version = "1.9.3-9";
    propagatedBuildInputs = with prev.python3Packages; old.propagatedBuildInputs ++ [ astroid pylint ];
  });
  haskellPackages = prev.haskellPackages.override {
    overrides = hself: hsuper: {
      # Can add/override packages here
      thumbnail = prev.haskell.lib.doJailbreak hsuper.thumbnail;
    };
  };
}


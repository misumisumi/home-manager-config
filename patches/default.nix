{ nixpkgs-stable, ... }: [
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
  (final: prev: {
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
  })
  (final: prev: {
    ranger = prev.ranger.overridePythonAttrs (old: {
      src = prev.fetchFromGitHub {
        owner = "ranger";
        repo = "ranger";
        rev = "136416c7e2ecc27315fe2354ecadfe09202df7dd";
        sha256 = "09hvqnk8hvn2mv8m5w389q63wspyfksmwzkr7p8n70kfmfahlvlx";
      };
      version = "1.9.3-9";
      propagatedBuildInputs = with prev.python3Packages; old.propagatedBuildInputs ++ [ astroid pylint ];
      preConfigure =
        let
          preview4linux = ''
            # Specify path to Überzug
            # substituteInPlace ranger/ext/img_display.py \
            #   --replace "Popen(['ueberzug'" "Popen(['${prev.ueberzug}/bin/ueberzug'"

            # Use iterm2 as the default preview image method
            substituteInPlace ranger/config/rc.conf \
              --replace 'set preview_images_method w3m' 'set preview_images_method iterm2'
          '';
        in
        old.preConfigure + preview4linux;
    }
    );
  })
  (final: prev: {
    haskellPackages = prev.haskellPackages.override {
      overrides = hself: hsuper: {
        # Can add/override packages here
        thumbnail = prev.haskell.lib.doJailbreak hsuper.thumbnail;
      };
    };
  })
  (final: prev: {
    tmuxPlugins =
      prev.tmuxPlugins
      // {
        dracula = prev.tmuxPlugins.dracula.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "dracula";
            repo = "tmux";
            rev = "ffc6ef8efbe556fa908aee6615f0781348337faa";
            sha256 = "0a3vrp14pz0mpr7629grysmw6gf4hahvbiarafkl1nckll5yihyk";
          };
        });
      };
  })

]


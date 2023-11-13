# ranger (CLI Filer) conf
# ranger need writable conf dir.
# If you want to edit rc.conf (ranger preferences), you muse use nixpkgs override like this.
{ lib, config, pkgs, ... }:
let
  preview4linux = ''
    # Specify path to Überzug
    # substituteInPlace ranger/ext/img_display.py \
    #   --replace "Popen(['ueberzug'" "Popen(['${pkgs.ueberzug}/bin/ueberzug'"

    # Use Überzug as the default method
    substituteInPlace ranger/config/rc.conf \
      --replace 'set preview_images_method w3m' 'set preview_images_method iterm2'
  '';
  preview4mac = ''
    # Use kitty as the default method
    substituteInPlace ranger/config/rc.conf \
      --replace 'set preview_images_method w3m' 'set preview_images_method iterm2'
  '';

  ranger = pkgs.ranger.overrideAttrs (r: {
    src = pkgs.fetchFromGitHub {
      owner = "ranger";
      repo = "ranger";
      rev = "136416c7e2ecc27315fe2354ecadfe09202df7dd";
      sha256 = "09hvqnk8hvn2mv8m5w389q63wspyfksmwzkr7p8n70kfmfahlvlx";
    };
    preConfigure = r.preConfigure + preview4linux;
  });
in
{
  home = {
    packages = with pkgs; [ ranger trash-cli ];
    activation = {
      rangerActivatioinAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -d ${config.home.homeDirectory}/.config/ranger ]; then
          mkdir ${config.home.homeDirectory}/.config/ranger
        fi
      '';
    };
    shellAliases = {
      tm = "trash-put";
      tls = "trash-list";
      tre = "trash-restore";
      temp = "trash-empty";
      trm = "trash-rm";
    };
  };
  xdg = {
    configFile = {
      "ranger/rifle.conf".source = ./ranger/rifle.conf;
    };
  };
}

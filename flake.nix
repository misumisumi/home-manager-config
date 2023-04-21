{
  description = "Each my machine NixOS System Flake Configuration";

  inputs = {};

  outputs = inputs: {
    nixosModules = {
      for-nixos = import ./modules/for-nixos.nix;
      for-hm = import ./modules/for-hm.nix;
    };
  };
}

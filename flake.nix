{
  description = "My common dotfiles";

  outputs = inputs: {
    nixosModules = {
      home-manager = import ./modules/home-manager.nix;
    };
  };
}

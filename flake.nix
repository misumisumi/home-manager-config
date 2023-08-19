{
  description = "My common dotfiles";

  inputs = { };

  outputs = inputs: {
    nixosModules = {
      dotfiles = import ./modules/dotfiles.nix;
    };
  };
}

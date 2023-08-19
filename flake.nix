{
  description = "My common dotfiles";

  inputs = { };

  outputs = inputs: {
    nixosModules = {
      core = import ./modules/core.nix;
      extra = import ./modules/extra.nix;
      tmux = import ./modules/tmux.nix;
    };
  };
}
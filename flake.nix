{
  description = "My common dotfiles";

  inputs = { };

  outputs = inputs: {
    nixosModules = {
      core = import ./modules/core.nix;
      extra = import ./modules/extra.nix;
      minimal = import ./modules/minimal.nix;
      tmux = import ./modules/tmux.nix;
    };
  };
}

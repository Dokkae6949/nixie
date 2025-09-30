{ inputs
, outputs
, config
, lib
, pkgs
, ...
}:

{
  imports =[
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops

    ./disk-configuration.nix
    ./hardware-configuration.nix

    ./configuration
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      # Opinionated: disable global registry
      flake-registry = "";

      trusted-users = ["root" "@wheel"];

      substituters = ["https://walker.cachix.org"];
      trusted-public-keys = ["walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="];
    };

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # !!! Danger !!!
  # Do not change this value.
  system.stateVersion = "25.05";
}

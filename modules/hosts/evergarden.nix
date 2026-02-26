{ config, inputs, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
in
{
  # Register evergarden-specific aspects (excluded from auto-import via _ prefix).
  flake.modules.nixos.evergarden = import ./_evergarden;

  # Host composition: list the aspects that make up this machine.
  configurations.nixos.evergarden.module = { lib, ... }: {
    imports = [
      nixos.overlays
      nixos.sops
      nixos.impermanence
      nixos.database
      nixos.desktops
      nixos.security
      nixos.shells
      nixos.services
      nixos.hardware
      nixos.virtualisation
      nixos.evergarden
    ];

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        trusted-users = [ "root" "@wheel" ];
        substituters = [
          "https://walker.cachix.org"
          "https://niri.cachix.org"
        ];
        trusted-public-keys = [
          "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        ];
      };

      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    system.stateVersion = "25.05";
    nixpkgs.hostPlatform = "x86_64-linux";
  };

  # User configuration: full kurisu environment + evergarden-specific additions.
  configurations.homeManager."kurisu@evergarden" = {
    system = "x86_64-linux";
    module = {
      imports = [
        homeManager.kurisu
        homeManager.kurisu-evergarden
      ];

      home = {
        username = "kurisu";
        homeDirectory = "/home/kurisu";
        stateVersion = "25.05";
      };

      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";
    };
  };
}

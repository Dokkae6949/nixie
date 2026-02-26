{ config, inputs, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
in
{
  configurations.nixos.evergarden.module = { lib, ... }: {
    imports = [
      inputs.disko.nixosModules.disko

      nixos.overlays
      nixos.sops
      nixos.impermanence

      ../../hosts/evergarden/system/disk-configuration.nix
      ../../hosts/evergarden/system/hardware-configuration.nix
      ../../hosts/evergarden/system/configuration
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
    networking.hostName = "evergarden";
  };

  configurations.homeManager."kurisu@evergarden" = {
    system = "x86_64-linux";
    module = { pkgs, ... }: {
      imports = [
        homeManager.overlays
        homeManager.sops
        ../../hosts/evergarden/homes/kurisu/configuration
      ];

      home = {
        username = "kurisu";
        homeDirectory = "/home/kurisu";

        packages = with pkgs; [
          quickshell
          inotify-tools
        ];

        stateVersion = "25.05";
      };

      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";
    };
  };
}

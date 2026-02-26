{ config, inputs, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
in
{
  configurations.nixos.shiina.module = { lib, config, ... }: {
    imports = [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480

      nixos.overlays
      nixos.sops
      nixos.impermanence
      nixos.niri

      ../../hosts/shiina/hardware-configuration.nix
    ];

    sops = {
      age.keyFile = "/persist/root/.config/sops/age/keys.txt";
      defaultSopsFile = ../../secrets/shiina.yaml;
      defaultSopsFormat = "yaml";
    };

    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/root/.config/sops"
        "/root/.ssh"
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
    };

    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    networking = {
      hostName = "shiina";
      networkmanager.enable = true;
    };

    time.timeZone = "Europe/Vienna";
    i18n.defaultLocale = "en_US.UTF-8";

    users = {
      mutableUsers = false;
      users = {
        root = {
          hashedPasswordFile = config.sops.secrets."users/root/password_hash".path;
        };
        kurisu = {
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."users/kurisu/password_hash".path;
          extraGroups = [ "wheel" "networkmanager" ];
        };
      };
    };

    sops.secrets."users/root/password_hash".neededForUsers = true;
    sops.secrets."users/kurisu/password_hash".neededForUsers = true;

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        trusted-users = [ "root" "@wheel" ];
        substituters = [
          "https://niri.cachix.org"
        ];
        trusted-public-keys = [
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

  configurations.homeManager."kurisu@shiina" = {
    system = "x86_64-linux";
    module = {
      imports = [
        homeManager.overlays
        homeManager.sops
        homeManager.git
        homeManager.helix
      ];

      sops = {
        age.keyFile = "/home/kurisu/.config/sops/age/keys.txt";
        defaultSopsFile = ../../secrets/shiina.yaml;
        defaultSopsFormat = "yaml";
      };

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

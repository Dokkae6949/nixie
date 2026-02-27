{ den, inputs, ... }:
{
  den.hosts.x86_64-linux.shiina = {
    instantiate = { modules }: inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = { inherit inputs; };
    };
  };

  den.aspects.shiina = {
    nixos = { config, pkgs, ... }: {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ./_shiina/hardware-configuration.nix
      ];

      sops = {
        age.keyFile = "/persist/root/.config/sops/age/keys.txt";
        defaultSopsFile = ../../secrets/shiina.yaml;
        defaultSopsFormat = "yaml";
        secrets."users/root/password_hash".neededForUsers  = true;
        secrets."users/kurisu/password_hash".neededForUsers = true;
      };

      users = {
        mutableUsers = false;
        users = {
          root.hashedPasswordFile   = config.sops.secrets."users/root/password_hash".path;
          root.shell                = pkgs.fish;
          kurisu.isNormalUser       = true;
          kurisu.hashedPasswordFile = config.sops.secrets."users/kurisu/password_hash".path;
          kurisu.shell              = pkgs.fish;
          kurisu.extraGroups        = [ "wheel" "networkmanager" ];
        };
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
    };

    includes = [
      den.aspects.nix
      den.aspects.overlays
      den.aspects.fish
      den.aspects.sops
      den.aspects.impermanence
      den.aspects.niri
    ];
  };
}


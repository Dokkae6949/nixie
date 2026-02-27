{ den, inputs, ... }:
{
  # Declare shiina host (ThinkPad T480) with kurisu using a minimal aspect.
  den.hosts.x86_64-linux.shiina = {
    instantiate = { modules }: inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = { inherit inputs; };
    };

    users.kurisu = {
      # Use the minimal shiina-specific aspect instead of the full kurisu one.
      aspect = "kurisu-shiina";
    };
  };

  # Shiina host aspect: minimal T480 config.
  den.aspects.shiina = {
    nixos = { lib, pkgs, config, ... }: {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ./_shiina/hardware-configuration.nix
      ];

      sops = {
        age.keyFile = "/persist/root/.config/sops/age/keys.txt";
        defaultSopsFile = ../../secrets/shiina.yaml;
        defaultSopsFormat = "yaml";
      };

      sops.secrets."users/root/password_hash".neededForUsers = true;
      sops.secrets."users/kurisu/password_hash".neededForUsers = true;

      users = {
        mutableUsers = false;
        users = {
          root = {
            hashedPasswordFile = config.sops.secrets."users/root/password_hash".path;
            shell = pkgs.fish;
          };
          kurisu = {
            isNormalUser = true;
            hashedPasswordFile = config.sops.secrets."users/kurisu/password_hash".path;
            shell = pkgs.fish;
            extraGroups = [ "wheel" "networkmanager" ];
          };
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

      nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in {
        settings = {
          experimental-features = "nix-command flakes";
          flake-registry = "";
          trusted-users = [ "root" "@wheel" ];
          substituters = [ "https://niri.cachix.org" ];
          trusted-public-keys = [
            "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          ];
        };
        channel.enable = false;
        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      };
    };

    includes = [
      den.aspects.overlays
      den.aspects.fish
      den.aspects.sops
      den.aspects.impermanence
      den.aspects.niri
    ];
  };

  # Minimal kurisu user aspect for shiina.
  den.aspects.kurisu-shiina = {
    homeManager = { ... }: {
      sops = {
        age.keyFile = "/home/kurisu/.config/sops/age/keys.txt";
        defaultSopsFile = ../../secrets/shiina.yaml;
        defaultSopsFormat = "yaml";
      };
    };

    includes = [
      den.aspects.overlays
      den.aspects.sops
      den.aspects.git
      den.aspects.helix
    ];
  };
}

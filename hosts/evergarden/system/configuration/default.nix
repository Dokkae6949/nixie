{ lib
, outputs
, ...
}:

let
  nm = outputs.nixosModules;
in
{
  imports = [
    nm.database
    nm.desktops
    nm.security
    nm.shells
    nm.services
    nm.hardware
  
    ./apps
    ./io

    ./boot.nix
    ./impermanence.nix
    ./sudo.nix
    ./users.nix
    ./sops.nix
  ];

  custom = {
    hardware = {
      keyboard = {
        enable = true;
        layout = "at";
      };

      keyd.enable = true;
    };

    database = {
      postgresql.enable = true;
    };
  
    desktops = {
      greeters = {
        enable = true;
        provider = "ly";
      };

      environments = {
        cosmic.enable = true;
        hyprland.enable = true;
        niri.enable = true;
      };
    };

    security = {
      desktop.enable = true;
    };

    shells = {
      fish = {
        enable = true;
        defaultFor = [ "root" "kurisu" ];
      };
    };

    services = {
      tailscale.enable = true;
    };
  };
}

{ ... }:
{
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

    virtualisation = {
      docker.enable = true;
    };
  };
}

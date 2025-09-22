{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.custom.security.desktop;
in
{
  options.custom.security.desktop = {
    enable = lib.mkEnableOption "Enable desktop security measures.";
  };

  config = lib.mkIf cfg.enable {
    security = {
      rtkit.enable = true;
      polkit.enable = true;
      pam.services.swaylock = {};
    };
  
    services = {
      passSecretService = {
        enable = true;
        package = pkgs.libsecret;
      };

      gnome.gnome-keyring.enable = true;
    };

    environment.systemPackages = with pkgs; [
      polkit_gnome
    ];

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };
  };
}

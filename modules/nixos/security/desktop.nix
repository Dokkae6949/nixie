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
      polkit.enable = true;

      pam.services.ly.enable = true;
      pam.services.ly.enableGnomeKeyring = true;
    };
  
    services = {
      gnome.gnome-keyring.enable = true;
    };

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
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
}

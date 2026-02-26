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

    systemd.user.services.pantheon-polkit-agent = {
      description = "Pantheon Polkit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
        # Environment = [
        #   "DISPLAY=:0"
        #   "WAYLAND_DISPLAY=${builtins.getEnv "WAYLAND_DISPLAY"}"
        # ];
      };
    };
  };
}

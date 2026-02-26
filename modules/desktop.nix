{ ... }:
{
  # NixOS: polkit, gnome-keyring, PAM integration for graphical sessions.
  flake.modules.nixos.desktop = { pkgs, ... }: {
    security = {
      polkit.enable = true;

      pam.services.ly = {
        enable = true;
        enableGnomeKeyring = true;
      };
    };

    services.gnome.gnome-keyring.enable = true;

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
      };
    };
  };
}

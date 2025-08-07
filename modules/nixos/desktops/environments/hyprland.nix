{ lib
, config
, ...
}:

let
  cfg = config.custom.desktops.environments.hyprland;
in
{
  options.custom.desktops.environments.hyprland = {
    enable = lib.mkEnableOption "Whether to enable the Hyprland window manager.";
  };

  config = lib.mkIf cfg.enable {
    # Weird bypass for "ly" display manager not being able to start hyprland.
    systemd.services.display-manager.environment = lib.mkIf (config.custom.desktops.greeters.enable && config.custom.desktops.greeters.provider == "ly") {
      XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  
    programs.hyprland = {
      enable = true;
      withUWSM = lib.mkDefault true;
      xwayland.enable = lib.mkDefault true;
    };
  };
}

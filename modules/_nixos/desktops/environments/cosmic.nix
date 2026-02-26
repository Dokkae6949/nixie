{ lib
, config
, ...
}:

let
  cfg = config.custom.desktops.environments.cosmic;
in
{
  options.custom.desktops.environments.cosmic = {
    enable = lib.mkEnableOption "Whether to enable the Cosmic desktop manager.";
  };

  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.cosmic = {
        enable = true;
        xwayland.enable = lib.mkDefault true;
      };
    };
  };
}

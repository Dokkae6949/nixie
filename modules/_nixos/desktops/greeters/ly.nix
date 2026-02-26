{ lib
, config
, ...
}:

let
  cfg = config.custom.desktops.greeters;
in
{
  config = lib.mkIf (cfg.enable && cfg.provider == "ly") {
    services.displayManager.ly = {
      enable = true;

      settings = {
        save = true;
        load = true;

        # Looks ugly
        text_in_center = false;
      };
    };
  };
}

{ lib
, config
, ...
}:

let
  cfg = config.custom.desktops.greeters;
in
{
  config = lib.mkIf (cfg.enable && cfg.provider == "cosmic") {
    services = {
      displayManager.cosmic-greeter = {
        enable = true;
      };
    };
  };
}

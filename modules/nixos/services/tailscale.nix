{ config
, lib
, ...
}:

let
  cfg = config.custom.services.tailscale;
in
{
  options.custom.services.tailscale = {
    enable = lib.mkEnableOption "Enable the tailscale service.";
  };

  config = lib.mkIf cfg.enable {
    service.tailscale = {
      enable = true;
    };
  };
}


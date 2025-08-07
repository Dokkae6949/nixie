{ lib
, config
, ...
}:

let
  cfg = config.custom.hardware.keyd;
in
{
  options.custom.hardware.keyd = {
    enable = lib.mkEnableOption "Whether to enable the keyd key remapping software.";
  };

  config = lib.mkIf cfg.enable {
    services.keyd = {
      enable = true;

      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, escape)";
              esc = "capslock";
              kpenter = "enter";
            };
          };
        };
      };
    };
  };
}

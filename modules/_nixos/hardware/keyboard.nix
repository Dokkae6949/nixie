{ lib
, config
, ...
}:

let
  cfg = config.custom.hardware.keyboard;
in
{
  options.custom.hardware.keyboard = {
    enable = lib.mkEnableOption "Whether to enable certain keyboard settings.";

    layout = lib.mkOption {
      type = lib.types.str;
      default = "at";
      description = "Keyboard layout for console and X11.";
      example = "at,us";
    };
  };

  config = lib.mkIf cfg.enable {
    console.useXkbConfig = true;

    services.xserver.xkb = {
      layout = cfg.layout;
      options = "terminate:ctrl_alt_bksp";
    };
  };
}

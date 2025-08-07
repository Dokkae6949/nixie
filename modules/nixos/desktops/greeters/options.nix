{ lib
, config
, ...
}:

let
  cfg = config.custom.desktops.greeters;
in
{
  options.custom.desktops.greeters = {
    enable = lib.mkEnableOption "Whether to enable a display manager to be used as a greeter.";
    provider = lib.mkOption {
      type = lib.types.enum [ "cosmic" "ly" ];
      default = "ly";
      description = "The greeter to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      { assertion = builtins.length (builtins.filter (x: x.enable) (lib.attrValues config.custom.desktops.environments)) > 0;
        message = "At least one environment must be enabled when a greeter is enabled.";
      }
    ];
  };
}

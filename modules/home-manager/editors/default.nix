{ lib
, config
, ...
}:

let
  cfg = config.custom.editors;
in
{
  imports = [
    ./helix.nix
    ./jetbrains.nix
  ];

  options.custom.editors = {
    defaultEditor = lib.mkOption {
      type = lib.types.enum [ "helix" ];
      default = null;
      description = "Which editor to use as the default one. If set to null the default editor won't be set explicitly.";
    };
  };

  config = lib.mkIf (cfg.defaultEditor != null) {
    assertions = [
      { assertion = (config.custom.editors.${cfg.defaultEditor}.enable);
        message = "Can't set an editor as the default if it is disabled.";
      }
    ];
  };
}

{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.custom.shells.fish;
in
{
  options.custom.shells.fish = {
    enable = lib.mkEnableOption "Enable the Fish shell.";

    defaultFor = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Users to set Fish as their default shell. If set the shell must be enabled.";
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.enable || cfg.defaultFor == [];
        message = "custom.shells.fish.enable must be true if defaultFor is not empty.";
      }
    ];

    # Actually enable and assign the shell
    programs = lib.mkIf cfg.enable {
      fish.enable = true;
    };

    users.users = lib.mkIf cfg.enable (
      lib.genAttrs cfg.defaultFor (user: {
        shell = lib.mkOverride 900 "${pkgs.fish}/bin/fish";
      })
    );
  };
}


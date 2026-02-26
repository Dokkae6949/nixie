{ lib
, config
, ...
}:

let
  cfg = config.custom.desktops.environments.hyprland.kanshi;
in
{
  options.custom.desktops.environments.hyprland.kanshi = {
    enable = lib.mkEnableOption "Whether to enable common kanshi profiles.";

    display = {
      identifier = lib.mkOption {
        type = lib.types.string;
        default = "eDP-1";
        description = "The identifier for the primary display.";
      };
      mode = lib.mkOption {
        type = lib.types.string;
        default = "2560x1600@165.02Hz";
        description = "The resolution and refresh rate the primary display should run at.";
      };
      scale = lib.mkOption {
        type = lib.types.nullOr lib.types.float;
        default = 1.0;
        description = "The scale of the primary display.";
      };
      position = lib.mkOption {
        type = lib.types.string;
        default = "0,0";
        description = "The position in x and y where the top left of the primary display should be at.";
      };
    };

    commonProfiles = {
      laptop = {
        enable = lib.mkEnableOption "Whether to add common laptop display profiles.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.kanshi = {
      enable = lib.mkDefault true;
    
      profiles = lib.mkIf cfg.commonProfiles.laptop.enable {
        laptop_standalone = {
          outputs = [
            { criteria = cfg.display.identifier;
              mode = cfg.display.mode;
              scale = cfg.display.scale;
              position = cfg.display.position;
              adaptiveSync = true;
            }
            { criteria = "*";
              status = "disable";
            }
          ];
        };
      };
    };
  };
}

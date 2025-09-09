{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.desktops.environments.niri;
in
{
  options.custom.desktops.environments.niri = {
    enable = lib.mkEnableOption "Whether to enable the niri user configurations and tools.";
  };

  config = lib.mkIf cfg.enable {
    home.programs = with pkgs; [
      brightnessctl
    ];
  };
}

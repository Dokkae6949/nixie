{ lib
, config
, pkgs
, inputs
, ...
}:

let
  cfg = config.custom.desktops.launchers.walker;
in
{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  options.custom.desktops.launchers.walker = {
    enable = lib.mkEnableOption "Whether to enable the walker launcher.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.app2unit
    ];
  
    programs = {
      walker = {
        enable = true;
        runAsService = false;
      };
    };
  };
}

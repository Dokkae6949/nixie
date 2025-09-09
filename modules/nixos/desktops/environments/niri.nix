{ lib
, config
, inputs
, ...
}:

let
  cfg = config.custom.desktops.environments.niri;
in
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.custom.desktops.environments.niri = {
    enable = lib.mkEnableOption "Whether to enable the Niri window manager.";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    programs.niri = {
      enable = true;
    };
  };
}

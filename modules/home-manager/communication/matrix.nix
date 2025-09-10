{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.communication.matrix;
in
{
  options.custom.communication.matrix = {
    enable = lib.mkEnableOption "Whether to enable matrix chat clients.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fluffychat
      cinny-desktop
    ];
  };
}

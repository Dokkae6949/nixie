{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.custom.tools.fileBrowser;
in
{
  options.custom.tools.fileBrowser = {
    enable = lib.mkEnableOption "Whether to enable GUI file browsers";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}

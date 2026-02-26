{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.communication.vesktop;
in
{
  options.custom.communication.vesktop = {
    enable = lib.mkEnableOption "Whether to enable the Vesktop Discord client.";
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
    };
  };
}

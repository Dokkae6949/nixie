{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.custom.virtualisation.docker;
in
{
  options.custom.virtualisation.docker = {
    enable = lib.mkEnableOption "Whether to enable docker tools.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      docker
      docker-compose
    ];
  };
}

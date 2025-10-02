{ lib
, config
, ...
}:

let
  cfg = config.custom.virtualisation.docker;
in
{
  options.custom.virtualisation.docker = {
    enable = lib.mkEnableOption "Whether to enable docker containerisation.";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };
}

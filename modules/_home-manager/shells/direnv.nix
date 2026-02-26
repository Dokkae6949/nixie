{ lib
, config
, ...
}:

let
  cfg = config.custom.shells.direnv;
in
{
  options.custom.shells.direnv = {
    enable = lib.mkEnableOption "Whether to enable the direnv shell environment tool.";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableBashIntegration = config.programs.bash.enable;
    };
  };
}

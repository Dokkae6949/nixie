{ lib
, config
, ...
}:

let
  cfg = config.custom.tools.eza;
in
{
  options.custom.tools.eza = {
    enable = lib.mkEnableOption "Whether to enable the ls alternative eza.";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
    };
  };
}

{ lib
, config
, ...
}:

let
  cfg = config.custom.terminals.foot;
in
{
  options.custom.terminals.foot = {
    enable = lib.mkEnableOption "Whether to enable the Foot terminal";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      
      settings = {
        
      };
    };
  };
}

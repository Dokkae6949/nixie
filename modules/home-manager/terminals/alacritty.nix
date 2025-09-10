{ lib
, config
, ...
}:

let
  cfg = config.custom.terminals.alacritty;
in
{
  options.custom.terminals.alacritty = {
    enable = lib.mkEnableOption "Whether to enable the Alacritty terminal";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      
      # theme = "catppuccin_mocha";
      settings = {
        general.import = ["colors.toml"];

        window = {
          padding = { x = 8; y = 8; };
        };
      };
    };
  };
}

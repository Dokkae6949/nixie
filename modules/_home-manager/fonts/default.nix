{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.fonts;
in
{
  options.custom.fonts = {
    enable = lib.mkEnableOption "Whether to add custom font-packs.";
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      material-symbols
      nerd-fonts.jetbrains-mono
      ibm-plex
      open-sans
    ];
  };
}


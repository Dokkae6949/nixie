{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.custom.editors.obsidian;
in
{
  options.custom.editors.obsidian = {
    enable = lib.mkEnableOption "Whether to enable the obsidian note taking editor.";
  };

  config = lib.mkIf cfg.enable {
    programs.obsidian = {
      enable = true;
    };
  };
}

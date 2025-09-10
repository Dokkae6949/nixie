{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.custom.editors.jetbrains;
in
{
  options.custom.editors.jetbrains = {
    enable = lib.mkEnableOption "Whether to enable the jetbrains editor suite.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (jetbrains.plugins.addPlugins jetbrains.idea-ultimate [])
      # (jetbrains.plugins.addPlugins jetbrains.webstorm [])
      # (jetbrains.plugins.addPlugins jetbrains.rust-rover [])
      # (jetbrains.plugins.addPlugins jetbrains.rider [])
      # (jetbrains.plugins.addPlugins jetbrains.clion [])
      # jetbrains.datagrip
    ];
  };
}

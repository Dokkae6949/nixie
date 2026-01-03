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
    home.packages = with pkgs.unstable; [
      (jetbrains.plugins.addPlugins jetbrains.idea [])
      (jetbrains.plugins.addPlugins jetbrains.datagrip [])
      (jetbrains.plugins.addPlugins jetbrains.phpstorm [])
      (jetbrains.plugins.addPlugins jetbrains.gateway [])
      # (jetbrains.plugins.addPlugins jetbrains.webstorm [])
      # (jetbrains.plugins.addPlugins jetbrains.rust-rover [])
      # (jetbrains.plugins.addPlugins jetbrains.rider [])
      # (jetbrains.plugins.addPlugins jetbrains.clion [])
    ];
  };
}

{ lib
, pkgs
, config
, inputs
, ...
}:

let
  cfg = config.custom.editors.jetbrains;

  plugins = with inputs.nix-jetbrains-plugins.plugins."${lib.system}"; [
    idea."2025.2"."com.github.copilot"
  ];
in
{
  options.custom.editors.jetbrains = {
    enable = lib.mkEnableOption "Whether to enable the jetbrains editor suite.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.unstable; [
      (jetbrains.plugins.addPlugins jetbrains.idea plugins)
      (jetbrains.plugins.addPlugins jetbrains.datagrip [])
      (jetbrains.plugins.addPlugins jetbrains.phpstorm [])
      (jetbrains.plugins.addPlugins jetbrains.gateway [])
      (jetbrains.plugins.addPlugins jetbrains.pycharm [])
      # (jetbrains.plugins.addPlugins jetbrains.webstorm [])
      # (jetbrains.plugins.addPlugins jetbrains.rust-rover [])
      # (jetbrains.plugins.addPlugins jetbrains.rider [])
      # (jetbrains.plugins.addPlugins jetbrains.clion [])
    ];
  };
}

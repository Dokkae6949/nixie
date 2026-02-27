{ inputs, ... }:
{
  den.aspects.jetbrains.homeManager = { pkgs, ... }: {
    home.packages = let
      plugins = with inputs.nix-jetbrains-plugins.plugins."${pkgs.stdenv.hostPlatform.system}"; [
        idea."2025.2"."com.github.copilot"
      ];
    in with pkgs.unstable; [
      (jetbrains.plugins.addPlugins jetbrains.idea plugins)
      (jetbrains.plugins.addPlugins jetbrains.datagrip [])
      (jetbrains.plugins.addPlugins jetbrains.phpstorm [])
      (jetbrains.plugins.addPlugins jetbrains.gateway [])
      (jetbrains.plugins.addPlugins jetbrains.pycharm [])
    ];
  };
}

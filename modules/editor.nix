# Editor sub-aspects — include individually: den.aspects.editor.provides.helix
#                                              den.aspects.editor.provides.jetbrains
{ inputs, ... }:
{
  den.aspects.editor.provides.helix.homeManager = { pkgs, ... }: {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "term16_dark";
        editor = {
          line-number = "relative";
          text-width = 100;
        };
      };

      languages = {
        language-server.nixd = {
          command = "nixd";
          args = [ "--semantic-tokens=true" ];
        };
        language = [
          { name = "css";   auto-format = false; }
          { name = "typst"; indent = { tab-width = 2; unit = "  "; }; }
        ];
      };

      extraPackages = with pkgs; [ nixd yaml-language-server marksman ];
    };
  };

  den.aspects.editor.provides.jetbrains.homeManager = { pkgs, ... }: {
    home.packages = let
      plugins = with inputs.nix-jetbrains-plugins.plugins."${pkgs.stdenv.hostPlatform.system}"; [
        idea."2025.2"."com.github.copilot"
      ];
    in with pkgs.unstable; [
      (jetbrains.plugins.addPlugins jetbrains.idea       plugins)
      (jetbrains.plugins.addPlugins jetbrains.datagrip   [])
      (jetbrains.plugins.addPlugins jetbrains.phpstorm   [])
      (jetbrains.plugins.addPlugins jetbrains.gateway    [])
      (jetbrains.plugins.addPlugins jetbrains.pycharm    [])
    ];
  };
}

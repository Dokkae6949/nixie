{ ... }:
{
  flake.modules.homeManager.helix = { pkgs, ... }: {
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
          {
            name = "css";
            auto-format = false;
          }
          {
            name = "typst";
            indent = { tab-width = 2; unit = "  "; };
          }
        ];
      };

      extraPackages = with pkgs; [
        nixd
        yaml-language-server
        marksman
      ];
    };
  };
}

{ lib
, config
, pkgs
, inputs
, ...
}:

let
  cfg = config.custom.editors.helix;
in
{
  options.custom.editors.helix = {
    enable = lib.mkEnableOption "Whether to enable the Helix editor.";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = (config.custom.editors.defaultEditor == "helix");

      settings = {
        theme = "term16_dark";

        editor = {
          line-number = "relative";
          text-width = 100;
        };
      };

      languages = {
        language-server = {
          nixd = {
            command = "nixd";
            args = [ "--semantic-tokens=true" ];
            config.nixd = let
              host = "evergarden";
              flake = "(builtins.getFlake (toString ${inputs.self.outPath}))";
              nixosOptions = "${flake}.nixosConfigurations.${host}.options";
              homeManagerOptions = "${nixosOptions}.home-manager.users.type.getSubOptions []";
            in {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
              options = {
                nixos.expr = nixosOptions;
                home-manager.expr = homeManagerOptions;
              };
            };
          };

          rust = {
            command = "rust-analyzer";
          };

          qml = {
            command = "qmlls";
            args = [ ];
          };

          dockerfile = {
            command = "docker-language-server";
          };
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
        
        kdePackages.qtdeclarative

        just-lsp
        yaml-language-server
        unstable.tombi
        docker-compose-language-service
        docker-language-server
        tinymist

        rust-analyzer
        clang-tools
        ruff

        intelephense
        vscode-langservers-extracted
        typescript-language-server

        kotlin-language-server
        jdt-language-server

        marksman
      ];
    };
  };
}

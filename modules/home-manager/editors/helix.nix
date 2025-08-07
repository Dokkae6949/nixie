{ lib
, config
, pkgs
, self
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

      languages = {
        language-server = {
          nixd = {
            args = [ "--semantic-tokens=true" ];
            config.nixd = let
              flake = "(builtins.getFlake (toString ${self.outPath}))";
              nixosOptions = "${flake}.nixosConfigurations.${config.networking.hostName}.options";
              homeManagerOptions = "${nixosOptions}.home-manager.users.type.getSubOptions []";
            in {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
              options = {
                nixos.expr = nixosOptions;
                home-manager.expr = homeManagerOptions;
              };
            };
          };

          qml = {
            args = [ "-E" ];
          };
        };
      };

      extraPackages = with pkgs; [
        nixd
        
        kdePackages.qtdeclarative

        just-lsp
        yaml-language-server
        unstable.tombi

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

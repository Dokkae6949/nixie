{ lib
, config
, pkgs
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
        language-server.nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };

        language-server.qml = {
          command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
          args = [ "-E" ];
        };
      };
    };

    home.packages = with pkgs; [
      nixd
      kdePackages.qtdeclarative
    ];
  };
}

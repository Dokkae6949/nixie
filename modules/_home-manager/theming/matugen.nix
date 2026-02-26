{ inputs
, lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.theming.matugen;
in
{
  options.custom.theming.matugen = {
    enable = lib.mkEnableOption "Enable matugen for theme template generation.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs = {
      helix = {
        settings.theme = lib.mkDefault "matugen";
      };

      alacritty = {
        settings.general.import = lib.mkDefault [
          "colors.toml"
        ];
      };
    };
  };
}

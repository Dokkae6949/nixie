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
  imports = [
    inputs.matugen.nixosModules.default
  ];

  options.custom.theming.matugen = {
    enable = lib.mkEnableOption "Enable matugen for theme template generation.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      matugen
    ];

    programs.helix = {
      settings.theme = lib.mkForce "matugen";
    };
  };
}

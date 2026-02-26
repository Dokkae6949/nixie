{ inputs, ... }:
{
  # home-manager: matugen for material-you theme generation.
  flake.modules.homeManager.theming = { lib, pkgs, ... }: {
    home.packages = [
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs = {
      helix.settings.theme = lib.mkDefault "matugen";

      alacritty.settings.general.import = lib.mkDefault [ "colors.toml" ];
    };
  };
}

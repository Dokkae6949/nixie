{ inputs, ... }:
{
  # home-manager: matugen for material-you theme generation.
  den.aspects.theming.homeManager = { lib, pkgs, ... }: {
    home.packages = [
      inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs = {
      helix.settings.theme = lib.mkDefault "matugen";

      alacritty.settings.general.import = lib.mkDefault [ "colors.toml" ];
    };
  };
}

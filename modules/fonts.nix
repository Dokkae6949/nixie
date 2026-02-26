{ ... }:
{
  flake.modules.homeManager.fonts = { pkgs, ... }: {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      material-symbols
      nerd-fonts.jetbrains-mono
      ibm-plex
      open-sans
    ];
  };
}

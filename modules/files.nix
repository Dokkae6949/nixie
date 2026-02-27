{ ... }:
{
  den.aspects.files.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [ nautilus ];

    xdg.portal = {
      enable = true;

      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
}

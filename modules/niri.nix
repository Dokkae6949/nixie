{ inputs, ... }:
{
  flake.modules.nixos.niri = { pkgs, ... }: {
    imports = [ inputs.niri.nixosModules.niri ];

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
  };

  # home-manager: tools and utilities for the niri session.
  flake.modules.homeManager.niri = { pkgs, ... }: {
    home.packages = with pkgs; [
      brightnessctl
      playerctl
      nwww
      wl-mirror
      xwayland-satellite
    ];
  };
}

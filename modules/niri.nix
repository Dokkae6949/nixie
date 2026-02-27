{ inputs, ... }:
{
  den.aspects.niri.nixos = { pkgs, ... }: {
    imports = [ inputs.niri.nixosModules.niri ];

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    nix.settings = {
      substituters      = [ "https://niri.cachix.org" ];
      trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
  };

  den.aspects.niri.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      brightnessctl
      playerctl
      nwww
      wl-mirror
      xwayland-satellite
    ];
  };
}


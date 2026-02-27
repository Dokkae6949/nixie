{ inputs, ... }:
let
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: _prev: {
    quickshell = inputs.quickshell.packages.${final.stdenv.hostPlatform.system}.default;
    astal = inputs.astal.packages.${final.stdenv.hostPlatform.system}.default;
    nwww = inputs.nwww.packages.${final.stdenv.hostPlatform.system}.default;
    matugen = inputs.matugen.packages.${final.stdenv.hostPlatform.system}.default;
  };
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config = final.config;
    };
  };
in
{
  flake.overlays = { inherit additions modifications unstable-packages; };

  den.aspects.overlays.nixos = {
    nixpkgs.overlays = [ additions modifications unstable-packages ];
    nixpkgs.config.allowUnfree = true;
  };

  den.aspects.overlays.homeManager = {
    nixpkgs.overlays = [ additions modifications unstable-packages ];
    nixpkgs.config.allowUnfree = true;
  };
}

{ config, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  # Full kurisu user configuration.
  # Include homeManager.kurisu in a host to add the complete kurisu environment.
  flake.modules.homeManager.kurisu = { pkgs, ... }: {
    imports = [
      homeManager.overlays
      homeManager.sops
      homeManager.git
      homeManager.helix
      homeManager.fish
      homeManager.direnv
      homeManager.niri
      homeManager.walker
      homeManager.alacritty
      homeManager.bat
      homeManager.eza
      homeManager.files
      homeManager.sysdiag
      homeManager.obsidian
      homeManager.jetbrains
      homeManager.vesktop
      homeManager.spotify
      homeManager.fonts
      homeManager.theming
      homeManager.docker
    ];

    home.packages = with pkgs; [
      zellij
      jq
      quickshell
      inotify-tools
    ];
  };

  # Evergarden-specific additions for kurisu:
  # browsers, cursor theme, monitor layout, swayidle, and sops config.
  flake.modules.homeManager.kurisu-evergarden = import ./_kurisu;
}

{ config, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  # Full kurisu user configuration.
  # Include homeManager.kurisu in a host to get the complete kurisu environment.
  flake.modules.homeManager.kurisu = { pkgs, ... }: {
    imports = [
      homeManager.overlays
      homeManager.sops
      homeManager.git
      homeManager.helix
      homeManager.audio
      homeManager.communication
      homeManager.desktops
      homeManager.editors
      homeManager.shells
      homeManager.terminals
      homeManager.tools
      homeManager.fonts
      homeManager.theming
      homeManager.virtualisation
    ];

    home.packages = with pkgs; [
      zellij
      jq
      quickshell
      inotify-tools
    ];

    custom = {
      shells = {
        direnv.enable = true;
        fish.enable = true;
      };

      desktops = {
        environments.niri.enable = true;
        launchers.walker.enable = true;
      };

      terminals.alacritty.enable = true;

      tools = {
        bat.enable = true;
        eza.enable = true;
        git.enable = true;
        fileBrowser.enable = true;
        systemDiagnostic.enable = true;
      };

      editors = {
        defaultEditor = "helix";
        helix.enable = true;
        jetbrains.enable = true;
        obsidian.enable = true;
      };

      communication = {
        vesktop.enable = true;
        matrix.enable = true;
      };

      audio.spotify.enable = true;
      fonts.enable = true;

      theming.matugen.enable = true;

      virtualisation.docker.enable = true;
    };
  };

  # Evergarden-specific additions for kurisu:
  # browsers, cursor theme, monitor layout, swayidle, and sops config.
  flake.modules.homeManager.kurisu-evergarden = import ./_kurisu;
}

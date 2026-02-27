{ den, ... }:
{
  # Full kurisu user aspect — applied to kurisu on evergarden via den's context pipeline.
  # Includes all HM feature aspects + evergarden-specific user config.
  den.aspects.kurisu = {
    homeManager = { ... }: {
      imports = [ (import ./_kurisu) ];
    };

    includes = [
      den.aspects.overlays
      den.aspects.sops
      den.aspects.git
      den.aspects.helix
      den.aspects.fish
      den.aspects.direnv
      den.aspects.niri
      den.aspects.walker
      den.aspects.alacritty
      den.aspects.bat
      den.aspects.eza
      den.aspects.files
      den.aspects.sysdiag
      den.aspects.obsidian
      den.aspects.jetbrains
      den.aspects.vesktop
      den.aspects.spotify
      den.aspects.fonts
      den.aspects.theming
      den.aspects.docker
    ];
  };
}

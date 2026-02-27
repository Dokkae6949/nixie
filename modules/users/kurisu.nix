{ den, ... }:
{
  # Kurisu registers herself to her hosts — hosts no longer declare users.
  nixie.users = [
    { name = "kurisu"; host = "evergarden"; }
    { name = "kurisu"; host = "shiina"; aspect = "kurisu-shiina"; }
  ];

  # Full kurisu environment — applied on evergarden via den's ctx.user pipeline.
  den.aspects.kurisu = {
    homeManager = { ... }: {
      imports = [ (import ./_kurisu) ];
    };

    includes = [
      den.aspects.overlays
      den.aspects.sops
      den.aspects.git
      den.aspects.editor.provides.helix
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
      den.aspects.editor.provides.jetbrains
      den.aspects.vesktop
      den.aspects.spotify
      den.aspects.fonts
      den.aspects.theming
      den.aspects.docker
    ];
  };

  # Minimal kurisu environment for the shiina (T480) host.
  den.aspects.kurisu-shiina = {
    homeManager = { ... }: {
      sops = {
        age.keyFile = "/home/kurisu/.config/sops/age/keys.txt";
        defaultSopsFile = ../../secrets/shiina.yaml;
        defaultSopsFormat = "yaml";
      };
    };

    includes = [
      den.aspects.overlays
      den.aspects.sops
      den.aspects.git
      den.aspects.editor.provides.helix
    ];
  };
}


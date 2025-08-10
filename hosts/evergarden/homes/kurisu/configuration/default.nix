{ outputs
, ...
}:

let
  hmm = outputs.homeManagerModules;
in
{
  imports = [
    hmm.audio
    hmm.communication
    hmm.desktops
    hmm.editors
    hmm.shells
    hmm.terminals
    hmm.tools
    hmm.fonts
    hmm.theming
  
    ./browsers
    ./sops.nix
    ./qt.nix
    ./monitors.nix
  ];

  custom = {
    shells = {
      # A shell environment management/helper tool.
      direnv.enable = true;
    
      fish.enable = true;
    };

    desktops = {
      environments.hyprland.hypridle.enable = true;
    };

    terminals = {
      alacritty.enable = true;
    };

    tools = {
      bat.enable = true;
      eza.enable = true;
      git.enable = true;
      systemDiagnostic.enable = true;
    };

    editors = {
      defaultEditor = "helix";
    
      helix.enable = true;
    };

    communication = {
      vesktop.enable = true;
    };

    audio = {
      spotify.enable = true;
    };

    fonts.enable = true;

    theming = {
      matugen.enable = true;
    };
  };
}

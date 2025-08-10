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
    hmm.editors
    hmm.shells
    hmm.terminals
    hmm.tools
    hmm.fonts
    hmm.theming
  
    ./browsers
    ./sops.nix
    ./qt.nix
    ./kanshi.nix
  ];

  custom = {
    shells = {
      # A shell environment management/helper tool.
      direnv.enable = true;
    
      fish.enable = true;
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

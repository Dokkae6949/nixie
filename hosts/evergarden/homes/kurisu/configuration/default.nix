{ pkgs
, ...
}:

{
  imports = [
    ../../../../../modules/_home-manager/audio
    ../../../../../modules/_home-manager/communication
    ../../../../../modules/_home-manager/desktops
    ../../../../../modules/_home-manager/editors
    ../../../../../modules/_home-manager/shells
    ../../../../../modules/_home-manager/terminals
    ../../../../../modules/_home-manager/tools
    ../../../../../modules/_home-manager/fonts
    ../../../../../modules/_home-manager/theming
    ../../../../../modules/_home-manager/virtualisation
  
    ./browsers
    ./cursor.nix
    ./sops.nix
    ./qt.nix
    ./monitors.nix
    ./swayidle.nix
  ];

  home.packages = with pkgs; [
    zellij
    jq
  ];

  custom = {
    shells = {
      # A shell environment management/helper tool.
      direnv.enable = true;
    
      fish.enable = true;
    };

    desktops = {
      environments = {
        # hyprland.hypridle.enable = true;
        niri.enable = true;
      };

      launchers.walker.enable = true;
    };

    terminals = {
      alacritty.enable = true;
    };

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

    audio = {
      spotify.enable = true;
    };

    fonts.enable = true;

    theming = {
      matugen.enable = true;
    };

    virtualisation = {
      docker.enable = true;
    };
  };
}

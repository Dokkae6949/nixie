{ ... }:
{
  # Register legacy _nixos option modules as named dendritic aspects.
  # Each _nixos/* directory contains a NixOS module with custom.* options.
  flake.modules.nixos = {
    database      = import ./_nixos/database;
    desktops      = import ./_nixos/desktops;
    security      = import ./_nixos/security;
    shells        = import ./_nixos/shells;
    services      = import ./_nixos/services;
    hardware      = import ./_nixos/hardware;
    virtualisation = import ./_nixos/virtualisation;
  };

  # Register legacy _home-manager option modules as named dendritic aspects.
  flake.modules.homeManager = {
    audio          = import ./_home-manager/audio;
    communication  = import ./_home-manager/communication;
    desktops       = import ./_home-manager/desktops;
    editors        = import ./_home-manager/editors;
    shells         = import ./_home-manager/shells;
    terminals      = import ./_home-manager/terminals;
    tools          = import ./_home-manager/tools;
    fonts          = import ./_home-manager/fonts;
    theming        = import ./_home-manager/theming;
    virtualisation = import ./_home-manager/virtualisation;
  };
}

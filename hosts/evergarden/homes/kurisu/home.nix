{ inputs
, outputs
, pkgs
, ...
}:

{
  imports = [
		inputs.sops-nix.homeManagerModules.sops
  
    ./configuration
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "kurisu";
    homeDirectory = "/home/kurisu";

    packages = with pkgs; [
      quickshell
      inotify-tools
    ];    

    stateVersion = "25.05";
  };

  # Enable essential programs.
  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";
}

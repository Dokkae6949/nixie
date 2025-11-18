{ lib
, config
, inputs
, ...
}:

let
  cfg = config.custom.desktops.environments.niri;
in
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.custom.desktops.environments.niri = {
    enable = lib.mkEnableOption "Whether to enable the Niri window manager.";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    # Workaround for https://github.com/NixOS/nixpkgs/pull/297434#issuecomment-2348783988
    systemd.services.display-manager.environment = lib.mkIf (config.custom.desktops.greeters.enable && config.custom.desktops.greeters.provider == "ly") {
      XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    };

    programs.niri = {
      enable = true;
    };
  };
}

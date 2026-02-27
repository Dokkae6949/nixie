{ ... }:
{
  # NixOS: Ly console display manager / greeter.
  # Includes the workaround needed when running with niri.
  den.aspects.ly.nixos = { ... }: {
    services.displayManager.ly = {
      enable = true;

      settings = {
        save = true;
        load = true;
        text_in_center = false;
      };
    };

    # Workaround for https://github.com/NixOS/nixpkgs/pull/297434#issuecomment-2348783988
    systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
  };
}

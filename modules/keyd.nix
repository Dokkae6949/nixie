{ ... }:
{
  # NixOS: keyd daemon for system-wide key remapping.
  # Default layout: capslock → ctrl (hold) / escape (tap), esc → capslock.
  flake.modules.nixos.keyd = { ... }: {
    services.keyd = {
      enable = true;

      keyboards.default = {
        ids = [ "*" ];
        settings.main = {
          capslock = "overload(control, escape)";
          esc = "capslock";
          kpenter = "enter";
        };
      };
    };
  };
}

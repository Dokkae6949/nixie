{ ... }:
{
  den.default.homeManager = {
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };

  # den.default.nixos is merged into every NixOS configuration as a module.
  # We define the nixie.persist accumulator here so any feature aspect can
  # declare persistence needs without guarding on whether impermanence is present.
  den.default.nixos = {
    imports = [
      ({ lib, ... }: {
        options.nixie.persist = {
          directories = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
          files       = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
        };
      })
    ];
    system.stateVersion = "25.05";
  };
}


{ lib, inputs, ... }:
{
  flake.modules.nixos.impermanence = { lib, config, ... }: {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    # Signal to all other feature modules that impermanence is active.
    config.custom.impermanence.enable = lib.mkDefault true;

    # Persist the machine-id on every host using impermanence.
    config.environment.persistence."${config.custom.impermanence.persistPath}" = {
      hideMounts = true;
      files = [ "/etc/machine-id" ];
    };
  };
}

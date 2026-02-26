{ lib, inputs, ... }:
{
  # NixOS: sops-nix for system secrets.
  # Persists the age key and SSH directory when impermanence is active.
  flake.modules.nixos.sops = { lib, config, ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    config = lib.mkIf config.custom.impermanence.enable {
      environment.persistence."${config.custom.impermanence.persistPath}" = {
        directories = [
          "/root/.config/sops"
          "/root/.ssh"
        ];
      };
    };
  };

  # home-manager: sops-nix for user secrets.
  flake.modules.homeManager.sops = {
    imports = [ inputs.sops-nix.homeManagerModules.sops ];
  };
}

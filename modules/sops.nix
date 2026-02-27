{ inputs, ... }:
{
  # NixOS: sops-nix for system secrets.
  # Persistence dirs are gated on impermanence being present (options check).
  den.aspects.sops.nixos = { options, lib, ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    config = lib.mkIf (options.environment ? persistence) {
      environment.persistence."/persist".directories = [
        "/root/.config/sops"
        "/root/.ssh"
      ];
    };
  };

  # home-manager: sops-nix for user secrets.
  den.aspects.sops.homeManager = { ... }: {
    imports = [ inputs.sops-nix.homeManagerModules.sops ];
  };
}

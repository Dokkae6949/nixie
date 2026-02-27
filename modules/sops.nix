{ inputs, ... }:
{
  den.aspects.sops.nixos = { ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    # Declare persistence needs — impermanence picks these up when opted in.
    nixie.persist.directories = [ "/root/.config/sops" "/root/.ssh" ];
  };

  den.aspects.sops.homeManager = { ... }: {
    imports = [ inputs.sops-nix.homeManagerModules.sops ];
  };
}


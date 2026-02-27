{ inputs, ... }:
{
  # NixOS: opt-in impermanence via nix-community/impermanence.
  # Features declare their own persistence needs via the gated pattern below.
  # Opt in by including den.aspects.impermanence in a host.
  den.aspects.impermanence.nixos = { ... }: {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    environment.persistence."/persist" = {
      hideMounts = true;
      files = [ "/etc/machine-id" ];
    };
  };
}

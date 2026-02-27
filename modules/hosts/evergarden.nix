{ den, inputs, ... }:
{
  den.hosts.x86_64-linux.evergarden = {
    instantiate = { modules }: inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = { inherit inputs; };
    };
  };

  den.aspects.evergarden = {
    nixos = { ... }: {
      imports = [ (import ./_evergarden) ];
    };

    includes = [
      den.aspects.nix
      den.aspects.overlays
      den.aspects.fish
      den.aspects.keyd
      den.aspects.sops
      den.aspects.impermanence
      den.aspects.niri
      den.aspects.ly
      den.aspects.desktop
      den.aspects.tailscale
      den.aspects.docker
      den.aspects.postgresql
    ];
  };
}


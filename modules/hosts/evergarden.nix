{ den, inputs, ... }:
{
  # Declare evergarden host with kurisu as its user.
  # den automatically applies den.aspects.kurisu to kurisu via ctx.user.
  den.hosts.x86_64-linux.evergarden = {
    # Pass inputs via specialArgs so _evergarden/ NixOS modules can use them.
    instantiate = { modules }: inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = { inherit inputs; };
    };

    users.kurisu = { };
  };

  # Evergarden host aspect: composes all opted-in feature aspects.
  den.aspects.evergarden = {
    nixos = { lib, ... }: {
      imports = [ (import ./_evergarden) ];

      nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in {
        settings = {
          experimental-features = "nix-command flakes";
          flake-registry = "";
          trusted-users = [ "root" "@wheel" ];
          substituters = [
            "https://walker.cachix.org"
            "https://niri.cachix.org"
          ];
          trusted-public-keys = [
            "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
            "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          ];
        };

        channel.enable = false;

        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      };
    };

    includes = [
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

{ lib, config, inputs, ... }:
{
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.submodule {
      options.module = lib.mkOption {
        type = lib.types.deferredModule;
      };
    });
    default = {};
  };

  config.flake = {
    nixosConfigurations = lib.mapAttrs
      (name: { module }: inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; outputs = config.flake; };
        modules = [ module ];
      })
      config.configurations.nixos;

    # Expose reusable modules as flake outputs for backward compatibility.
    nixosModules = import ./_nixos;
  };
}

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

  config.flake.nixosConfigurations = lib.mapAttrs
    (name: { module }: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; outputs = config.flake; };
      modules = [
        # Always include base options so custom.impermanence.* is available
        # to all feature modules regardless of which host we're building.
        config.flake.modules.nixos._base
        module
      ];
    })
    config.configurations.nixos;
}

{ lib, ... }:
{
  # This aspect is always included in every NixOS configuration
  # to make custom.impermanence.* options available to all feature modules.
  flake.modules.nixos._base = {
    options.custom.impermanence = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether impermanence is enabled on this host.";
      };
      persistPath = lib.mkOption {
        type = lib.types.str;
        default = "/persist";
        description = "Path to the persistent storage directory.";
      };
    };
  };
}

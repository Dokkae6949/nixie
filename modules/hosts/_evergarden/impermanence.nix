{ options, lib, ... }:
{
  # Evergarden-specific persistence directories.
  # Gated on the impermanence nixos module being present.
  config = lib.mkIf (options.environment ? persistence) {
    environment.persistence."/persist".directories = [
      "/etc/nixos"
      "/run/media"
      "/etc/NetworkManager/system-connections"
    ];
  };
}

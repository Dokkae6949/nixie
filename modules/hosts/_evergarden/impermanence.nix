{ lib, config, ... }:
{
  # Evergarden-specific persistence directories.
  # Activated only when the nixos.impermanence aspect is included.
  config = lib.mkIf config.custom.impermanence.enable {
    environment.persistence."${config.custom.impermanence.persistPath}" = {
      directories = [
        "/etc/nixos"
        "/run/media"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}

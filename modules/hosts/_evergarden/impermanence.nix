{ ... }:
{
  # Evergarden-specific persistence directories.
  nixie.persist.directories = [
    "/etc/nixos"
    "/run/media"
    "/etc/NetworkManager/system-connections"
  ];
}

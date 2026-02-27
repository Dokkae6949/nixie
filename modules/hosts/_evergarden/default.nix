{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disk-configuration.nix
    ./battery.nix
    ./boot.nix
    ./impermanence.nix
    ./network.nix
    ./qemu.nix
    ./sops.nix
    ./steam.nix
    ./sudo.nix
    ./users.nix
  ];
}

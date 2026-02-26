{ config, pkgs, ... }:
{
  sops.secrets."users/root/password_hash".neededForUsers = true;
  sops.secrets."users/kurisu/password_hash".neededForUsers = true;

  users = {
    mutableUsers = false;

    users = {
      root = {
        hashedPasswordFile = config.sops.secrets."users/root/password_hash".path;
        shell = pkgs.fish;
      };

      kurisu = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."users/kurisu/password_hash".path;
        shell = pkgs.fish;

        extraGroups = [ "wheel" "docker" "networkmanager" "qemu-libvirtd" "libvirtd" "disk" "kvm" ];
      };
    };
  };
}

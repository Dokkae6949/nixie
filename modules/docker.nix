{ ... }:
{
  # NixOS: docker daemon with btrfs storage driver.
  flake.modules.nixos.docker = { ... }: {
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  # home-manager: docker CLI and compose tools.
  flake.modules.homeManager.docker = { pkgs, ... }: {
    home.packages = with pkgs; [
      docker
      docker-compose
    ];
  };
}

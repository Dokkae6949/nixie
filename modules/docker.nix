{ ... }:
{
  # NixOS: docker daemon with btrfs storage driver.
  den.aspects.docker.nixos = { ... }: {
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  # home-manager: docker CLI and compose tools.
  den.aspects.docker.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      docker
      docker-compose
    ];
  };
}

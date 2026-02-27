{ ... }:
{
  den.default.homeManager.home.stateVersion = "25.05";
  den.default.homeManager.programs.home-manager.enable = true;
  den.default.homeManager.systemd.user.startServices = "sd-switch";

  den.default.nixos.system.stateVersion = "25.05";
}

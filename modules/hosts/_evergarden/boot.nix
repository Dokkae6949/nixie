{ pkgs, ... }:
{
  boot = {
    kernelParams = [
      # https://unix.stackexchange.com/questions/353895/should-i-disable-nmi-watchdog-permanently-or-not
      "nmi_watchdog=0"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
        default = "saved";
      };
    };

    kernelPackages = pkgs.linuxPackages_zen;
  };
}

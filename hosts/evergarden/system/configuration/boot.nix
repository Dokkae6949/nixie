{ pkgs
, ...
}:

{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
        # efiInstallAsRemovable = true;
        default = "saved";
        # gfxmodeEfi = "1920x1200";
      };
    };

    kernelPackages = pkgs.linuxPackages_zen;
  };
}

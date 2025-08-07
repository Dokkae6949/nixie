{ inputs
, config
, lib
, pkgs
, modulesPath
, ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix")
    # Hardware specific default configuration
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-sync
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  boot = {
    initrd = {
      kernelModules = [ "amdgpu" ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "uas"
        "usb_storage"
        "sd_mod"
      ];
    };

    kernelModules = [ "kvm-amd" "fuse" ];
    extraModulePackages = [ ];
    blacklistedKernelModules = [ ];
    supportedFilesystems = ["ntfs"];

    # Setup the intel audio Digital Signal Processor.
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=3
    '';
  };

  time.hardwareClockInLocalTime = lib.mkDefault true;
  services.automatic-timezoned.enable = lib.mkDefault true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;
      powerManagement.finegrained = lib.mkDefault false;
      open = lib.mkForce true;

      # Overwrite the amd gpu bus Id because this laptop changes the
      # ID to from 5 to 6 if 2 disks are installed.
      prime = {
        amdgpuBusId = lib.mkDefault "PCI:6:0:0";
        nvidiaBusId = lib.mkDefault "PCI:1:0:0";
      };

      package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.latest;
    };

    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;

      extraPackages = with pkgs; [
        # vaapiVdpau
        nvidia-vaapi-driver
        libvdpau-va-gl
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };

  services.xserver.videoDrivers = lib.mkDefault ["amdgpu" "nvidia"];
}

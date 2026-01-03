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
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  boot = {
    initrd = {
      kernelModules = [ "amdgpu" "nvidia" ];
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

    kernelModules = [ "kvm-amd" "fuse" "nvidia-uvm" ];
    blacklistedKernelModules = [ "nouveau" ];
    supportedFilesystems = ["ntfs"];

    # Setup the intel audio Digital Signal Processor.
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=3
    '';

    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };

  time.hardwareClockInLocalTime = lib.mkDefault true;
  services.automatic-timezoned.enable = lib.mkDefault true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  environment.variables = {
    # Vaapi stuff
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";

    # Something?
    GBM_BACKEND = "nvidia-drm";

    # Prevent nouveu
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Required for  firefox
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };
  environment.systemPackages = with pkgs; [
    vdpauinfo
  ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      # powerManagement.finegrained = true;

      # Overwrite the amd gpu bus Id because this laptop changes the
      # ID to from 5 to 6 if 2 disks are installed.
      prime = {
        # offload.enable = true;
        # offload.enableOffloadCmd = true;
        sync.enable = true;
        amdgpuBusId = lib.mkDefault "PCI:6:0:0";
        nvidiaBusId = lib.mkDefault "PCI:1:0:0";
      };

      package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.latest;
    };

    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;

      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libvdpau-va-gl

        libva-utils
        libva
      ];
    };
  };

  services.xserver.videoDrivers = lib.mkDefault ["amdgpu" "nvidia"];

  # Symlink GPU to named paths
  services.udev.extraRules = ''
    # Symlink AMD iGPU to /dev/dri/amd-igpu
    KERNEL=="card*", \
      KERNELS=="0000:06:00.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/amd-igpu"

    # Symlink NVIDIA dGPU to /dev/dri/nvidia-dgpu
    KERNEL=="card*", \
      KERNELS=="0000:01:00.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/nvidia-dgpu"
  '';
}

# Configures the system to increase battery lifetime and performance.

{ ...
}:

{
  boot = {
    kernelParams = [
      # https://unix.stackexchange.com/questions/353895/should-i-disable-nmi-watchdog-permanently-or-not
      "nmi_watchdog=0"
    ];
  };

  # 1. Enables automatic pci runtime power management.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
  '';
}

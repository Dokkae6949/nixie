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

  services = {
    # 1. Enables automatic pci runtime power management.
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
    '';

    # See the following resources:
    # https://wiki.nixos.org/wiki/Laptop
    # https://www.reddit.com/r/NixOS/comments/1mio7is/nixos_and_battery_life/
    tlp = {
      enable = true;

      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;
        
        STOP_CHARGE_THRESH_BAT0 = 95;
      };
    };
  };

  # See the following resources:
  # https://wiki.nixos.org/wiki/Laptop
  # https://www.reddit.com/r/NixOS/comments/1mio7is/nixos_and_battery_life/
  powerManagement.powertop.enable = true;
}

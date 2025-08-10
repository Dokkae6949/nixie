{ ...
}:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      { profile = {
          name = "laptop_standalone";
          outputs = [
            { criteria = "eDP-1";
              mode = "2560x1600@165.02Hz";
              position = "0,0";
              scale = 1.0;
              adaptiveSync = true;
            }
          ];
        };
      }
      { profile = {
          name = "laptop_docked_single";
          outputs = [
            # Laptop internal monitor.
            { criteria = "eDP-1";
              status = "disable";
            }

            # Center monitor.
            { criteria = "DP-2";
              mode = "2560x1440@165.08Hz";
              position = "0,0";
              scale = 1.0;
              adaptiveSync = true;
            }
          ];
        };
      }
      { profile = {
          name = "docked_single";
          outputs = [
            # Center monitor.
            { criteria = "DP-2";
              mode = "2560x1440@165.08Hz";
              position = "0,0";
              scale = 1.0;
              adaptiveSync = true;
            }
          ];
        };
      }
      { profile = {
          name = "docked_multiple";
          outputs = [
            # Center monitor.
            { criteria = "DP-2";
              mode = "2560x1440@165.08Hz";
              position = "1920,0";
              scale = 1.0;
              adaptiveSync = true;
            }

            # Left monitor.
            { criteria = "DP-3";
              mode = "1920x1080@60Hz";
              position = "0,360";
              scale = 1.0;
            }

            # Right monitor.
            { criteria = "DP-4";
              mode = "1920x1080@60Hz";
              position = "4480,360";
              scale = 1.0;
            }
          ];
        };
      }
      { profile = {
          name = "laptop_docked_multiple";
          outputs = [
            # Laptop internal monitor.
            { criteria = "eDP-1";
              status = "disable";
            }

            # Center monitor.
            { criteria = "DP-2";
              mode = "2560x1440@165.08Hz";
              position = "1920,0";
              scale = 1.0;
              adaptiveSync = true;
            }

            # Left monitor.
            { criteria = "DP-3";
              mode = "1920x1080@60Hz";
              position = "0,360";
              scale = 1.0;
            }

            # Right monitor.
            { criteria = "DP-4";
              mode = "1920x1080@60Hz";
              position = "4480,360";
              scale = 1.0;
            }
          ];
        };
      }
    ];
  };
}


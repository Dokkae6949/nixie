{ pkgs
, ...
}:

{
  # home.packages = with pkgs; [
    # shikane
  # ];

  services.shikane = {
    # enable = true;

    settings.profile = [
      { name = "internal-only";
        output = [
          { search = "=eDP-1";
            enable = true;
            mode = "2560x1600@165.02Hz";
            position = "0,0";
            scale = 1.0;
            adaptive_sync = true;
          }
        ];
      }
      { name = "external-only-all";
        output = [
          { search = "=eDP-1";
            enable = false;
          }

          # Center monitor.
          { search = ["m=DELL G2724D" "s=C9S16Y3" "v=Dell Inc."];
            enable = true;
            mode = "2560x1440@165.08Hz";
            position = "1920,0";
            scale = 1.0;
            adaptive_sync = true;
          }

          # Left monitor.
          { search = ["m=HP P24h G4" "s=3CM2290QN8" "v=HP Inc."];
            enable = true;
            mode = "1920x1080@60Hz";
            position = "0,360";
            scale = 1.0;
            adaptive_sync = true;
          }

          # Right monitor.
          { search = ["m=DELL P2419H" "s=5156Q33" "v=Dell Inc."];
            enable = true;
            mode = "1920x1080@60Hz";
            position = "4480,360";
            scale = 1.0;
            adaptive_sync = true;
          }
        ];
      }
    ];
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      { profile = {
          name = "internal-only";
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
          name = "external-only-single";
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
          name = "external-single";
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
          name = "external-all";
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
          name = "external-only-all";
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


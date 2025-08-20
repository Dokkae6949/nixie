{ ...
}:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      { profile = {
          name = "internal-only";
          outputs = [
            { criteria = "California Institute of Technology 0x1609 Unknown";
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
            { criteria = "California Institute of Technology 0x1609 Unknown";
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
            { criteria = "Dell Inc. DELL G2724D C9S16Y3";
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
            { criteria = "Dell Inc. DELL G2724D C9S16Y3";
              mode = "2560x1440@165.08Hz";
              position = "1920,0";
              scale = 1.0;
              adaptiveSync = true;
            }

            # Left monitor.
            { criteria = "HP Inc. HP P24h G4 3CM2290QN8";
              mode = "1920x1080@60Hz";
              position = "0,360";
              scale = 1.0;
            }

            # Right monitor.
            { criteria = "Dell Inc. DELL P2419H 5156Q33";
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
            { criteria = "California Institute of Technology 0x1609 Unknown";
              status = "disable";
            }

            # Center monitor.
            { criteria = "Dell Inc. DELL G2724D C9S16Y3";
              mode = "2560x1440@165.08Hz";
              position = "1920,0";
              scale = 1.0;
              adaptiveSync = true;
            }

            # Left monitor.
            { criteria = "HP Inc. HP P24h G4 3CM2290QN8";
              mode = "1920x1080@60Hz";
              position = "0,360";
              scale = 1.0;
            }

            # Right monitor.
            { criteria = "Dell Inc. DELL P2419H 5156Q33";
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


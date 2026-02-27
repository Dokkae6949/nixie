{ pkgs
, lib
, ...
}:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      { profile = {
          name = "internal-only";
          exec = [
            "${lib.getExe' pkgs.matugen "matugen"} image $(cat ~/.wallpaper)"
          ];
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
          exec = [
            "${lib.getExe' pkgs.matugen "matugen"} image $(cat ~/.wallpaper)"
          ];
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
          exec = [
            "${lib.getExe' pkgs.matugen "matugen"} image $(cat ~/.wallpaper)"
          ];
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
          exec = [
            "${lib.getExe' pkgs.matugen "matugen"} image $(cat ~/.wallpaper)"
          ];
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
          exec = [
            "${lib.getExe' pkgs.matugen "matugen"} image $(cat ~/.wallpaper)"
          ];
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
      { profile = {
          name = "internal-hdmi-mirror";
          exec = [
            "${lib.getExe' pkgs.matugen "matugen"} image $(cat ~/.wallpaper)"
            "${lib.getExe' pkgs.wl-mirror "wl-mirror"} --fullscreen-output HDMI-A-1 eDP-1"
          ];
          outputs = [
            { criteria = "California Institute of Technology 0x1609 Unknown";
              mode = "2560x1600@165.02Hz";
              position = "0,0";
              scale = 1.0;
              adaptiveSync = true;
            }
            { criteria = "HDMI-A-1"; }
          ];
        };
      }
    ];
  };
}


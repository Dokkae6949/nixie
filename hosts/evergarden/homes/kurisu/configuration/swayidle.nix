{ pkgs
, ...
}:

let
  display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
in
{
  services.swayidle =  {
    enable = true;

    # Timouts configured in seconds
    timeouts = [
      { timeout = 60 * 2;
        command = display "off";
      }
      { timeout = 60 * 10;
        command = "${pkgs.systemd}/bin/systemctl hybrid-sleep";
      }
    ];

    events = [
      { event = "before-sleep";
        command = display "off";
      }
      { event = "after-resume";
        command = display "on";
      }
    ];
  };
}

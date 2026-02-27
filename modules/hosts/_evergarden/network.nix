{ ... }:
{
  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hostName = "evergarden";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];

      trustedInterfaces = [ "docker0" ];
    };

    extraHosts = ''
      10.10.11.221 2million.htb
    '';
  };
}

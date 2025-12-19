{ ...
}:

{
  users.users = {
    kurisu.extraGroups = [ "networkmanager" ];
  };

  networking = {
    hostName = "evergarden";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];

      trustedInterfaces = [ "docker0" ];
    };
  };
}

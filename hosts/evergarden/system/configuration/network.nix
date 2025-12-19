{ ...
}:

{
  systemd.services.NetworkManager-wait-online.enable = false;

  networking.extraHosts = ''
    10.10.11.221 2million.htb
  '';
}

{ config
, ...
}:

{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../../secrets/default.yaml;
    defaultSopsFormat = "yaml";
  };
}

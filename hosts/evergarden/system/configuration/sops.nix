{ config
, ...
}:

{
  sops = {
    age.keyFile = "/persist/root/.config/sops/age/keys.txt";

    defaultSopsFile = ../../../../secrets/evergarden.yaml;
    defaultSopsFormat = "yaml";
  };
}

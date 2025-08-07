{ config
, inputs
, ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "/persist/root/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets/default.yaml;
    defaultSopsFormat = "yaml";
  };
}

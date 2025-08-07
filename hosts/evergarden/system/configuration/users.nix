{ pkgs
, config
, ...
}:

{
  sops.secrets."users/root/password_hash".neededForUsers = true;
  sops.secrets."users/kurisu/password_hash".neededForUsers = true;

  users = {
    mutableUsers = false;

    users = {
      root = {
        hashedPasswordFile = config.sops.secrets."users/root/password_hash".path;
      };

      kurisu = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."users/kurisu/password_hash".path;

        extraGroups = [
          "wheel"
        ];
      };
    };
  };
}

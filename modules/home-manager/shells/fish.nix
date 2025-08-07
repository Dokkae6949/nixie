{ lib
, config
, ...
}:

let
  cfg = config.custom.shells.fish;
in
{
  options.custom.shells.fish = {
    enable = lib.mkEnableOption "Whether to enable the Fish shell";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      # Disable annoying welcome message.
      shellInit = ''
        set fish_greeting
      '';

      shellAliases = lib.mkDefault {
        e = "$EDITOR";

        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";

        l = "ls -la";
        ll = "ls -l";
      };
    };
  };
}

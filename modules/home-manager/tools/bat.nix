{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.tools.bat;
in
{
  options.custom.tools.bat = {
    enable = lib.mkEnableOption "Whether to enable the cat alternative bat.";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;

      config = {
        theme = "Catppuccin Mocha";
      };

      themes = {
        "Catppuccin Mocha" = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat"; # Bat uses sublime syntax for its themes
            rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
            sha256 = "lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
          };

          file = "themes/Catppuccin\ Mocha.tmTheme";
        };
      };
    };
  };
}

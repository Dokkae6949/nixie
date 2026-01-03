{ lib
, config
, ...
}:

let
  cfg = config.custom.tools.git;
in
{
  options.custom.tools.git = {
    enable = lib.mkEnableOption "Whether to enable the git versioning tool.";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings.user = {
        name = "Dokkae6949";
        email = "finnliry@gmail.com";

        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };

      ignores = [
        ".idea/"
        ".helix/"
        ".direnv/"
        
        ".envrc"
        ".ignore"
      ];
    };
  };
}

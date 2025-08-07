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

      userName = "Dokkae6949";
      userEmail = "finnliry@gmail.com";

      ignores = [
        ".idea/"
        ".helix/"
        ".direnv/"
        
        ".envrc"
        ".ignore"
      ];

      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };
  };
}

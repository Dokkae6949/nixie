{ ... }:
{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Dokkae6949";
          email = "finnliry@gmail.com";
        };

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

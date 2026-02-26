{ ... }:
{
  flake.modules.homeManager.direnv = { config, ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableBashIntegration = config.programs.bash.enable;
    };
  };
}

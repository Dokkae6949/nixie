{ inputs, ... }:
{
  flake.modules.homeManager.walker = { pkgs, ... }: {
    imports = [ inputs.walker.homeManagerModules.default ];

    home.packages = with pkgs; [ unstable.app2unit ];

    programs.walker = {
      enable = true;
      runAsService = true;
    };
  };
}

{ ... }:
{
  flake.modules.homeManager.sysdiag = { pkgs, ... }: {
    home.packages = with pkgs; [
      btop
      nvtopPackages.full
    ];
  };
}

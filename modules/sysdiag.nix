{ ... }:
{
  den.aspects.sysdiag.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      btop
      nvtopPackages.full
    ];
  };
}

{ ... }:
{
  den.aspects.obsidian.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [ obsidian ];
  };
}

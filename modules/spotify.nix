{ ... }:
{
  den.aspects.spotify.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [ spotify ];
  };
}

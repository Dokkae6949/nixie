{ ... }:
{
  den.aspects.alacritty.homeManager = { ... }: {
    programs.alacritty = {
      enable = true;

      settings = {
        general.import = [ "colors.toml" ];

        window.padding = { x = 8; y = 8; };
      };
    };
  };
}

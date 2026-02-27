{ inputs, ... }:
{
  den.aspects.walker.nixos = { ... }: {
    nix.settings = {
      substituters       = [ "https://walker.cachix.org" ];
      trusted-public-keys = [ "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM=" ];
    };
  };

  den.aspects.walker.homeManager = { pkgs, ... }: {
    imports = [ inputs.walker.homeManagerModules.default ];

    home.packages = with pkgs; [ unstable.app2unit ];

    programs.walker = {
      enable = true;
      runAsService = true;
    };
  };
}


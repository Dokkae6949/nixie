{ inputs
, ...
}:

{
  # Adds custom packages from the 'pkgs' directory.
  additions = final: _prev: import ../pkgs final.pkgs;

  # Contains any other overlays and modifications to packages.
  modifications = final: prev: {
    quickshell = inputs.quickshell.packages.${final.system}.default;
    astal = inputs.astal.packages.${final.system}.default;
    nwww = inputs.nwww.packages.${final.system}.default;
  };
  
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'.
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = final.config;
    };
  };
}

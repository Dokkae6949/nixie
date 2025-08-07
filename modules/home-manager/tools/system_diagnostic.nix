{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.tools.systemDiagnostic;
in
{
  options.custom.tools.systemDiagnostic = {
    enable = lib.mkEnableOption "Whether to enable various system diagnostic tools.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      btop
      nvtopPackages.full
    ];
  };
}

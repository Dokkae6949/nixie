{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.custom.audio.spotify;
in
{
  options.custom.audio.spotify = {
    enable = lib.mkEnableOption "Whether to enable Spotify.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}

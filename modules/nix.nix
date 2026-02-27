# Shared nix daemon settings — applied to all hosts via includes.
# Each feature aspect (niri, walker) adds its own substituter.
{ inputs, ... }:
{
  den.aspects.nix.nixos = { lib, ... }: {
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        trusted-users = [ "root" "@wheel" ];
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
  };
}

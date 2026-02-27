# Nixie namespace — custom flake-parts options for self-contained declarations.
# Users register themselves to hosts here; nixie wires everything into den.
{ lib, config, ... }:
{
  options.nixie.users = lib.mkOption {
    default = [];
    type = lib.types.listOf (lib.types.submodule {
      options = {
        name   = lib.mkOption { type = lib.types.str; };
        host   = lib.mkOption { type = lib.types.str; };
        system = lib.mkOption { type = lib.types.str; default = "x86_64-linux"; };
        aspect = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; };
      };
    });
  };

  config.den.hosts = lib.mkMerge (map (u: {
    ${u.system}.${u.host}.users.${u.name} =
      lib.optionalAttrs (u.aspect != null) { aspect = u.aspect; };
  }) config.nixie.users);
}

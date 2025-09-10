{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.custom.database.postgresql;
in
{
  options.custom.database.postgresql = {
    enable = lib.mkEnableOption "Enable the Postgres service";
  };

  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;

      package = pkgs.postgresql_17;  
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser    origin-address  auth-method
        local all       postgres                  trust
        host  all       all       127.0.0.1/32    trust
        host  all       all       ::1/128         trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres' CREATEDB;
        CREATE DATABASE postgres;
        GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;
      '';
    };
  };
}


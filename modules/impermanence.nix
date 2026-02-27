{ inputs, ... }:
{
  # Opt-in impermanence. When included, reads nixie.persist.{directories,files}
  # accumulated by feature aspects — no per-feature mkIf guards needed.
  den.aspects.impermanence.nixos = { config, ... }: {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    environment.persistence."/persist" = {
      hideMounts = true;
      files       = [ "/etc/machine-id" ] ++ config.nixie.persist.files;
      directories = config.nixie.persist.directories;
    };
  };
}


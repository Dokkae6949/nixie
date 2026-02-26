{ ... }:
{
  # NixOS: enable fish system-wide so users can be assigned fish as their shell.
  flake.modules.nixos.fish = { pkgs, ... }: {
    programs.fish.enable = true;
    environment.shells = [ pkgs.fish ];
  };

  # home-manager: full fish configuration with starship prompt.
  flake.modules.homeManager.fish = { pkgs, ... }: {
    programs = {
      fish = {
        enable = true;

        shellInit = ''
          set fish_greeting
        '';

        shellAliases = {
          e = "$EDITOR";

          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          "....." = "cd ../../../..";
          "......" = "cd ../../../../..";

          tree = "${pkgs.eza}/bin/eza --color=always --tree";
          ls = "${pkgs.eza}/bin/eza --color=always --group-directories-first --icons";
          ll = "${pkgs.eza}/bin/eza -la --icons --octal-permissions --group-directories-first";
          l = "${pkgs.eza}/bin/eza --long --all --group --group-directories-first";
          lx = "${pkgs.eza}/bin/eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons";

          cat = "${pkgs.bat}/bin/bat -Pp";
        };
      };

      starship = {
        enable = true;

        settings = {
          character = {
            success_symbol = "[[](mauve) ❯](maroon)";
            error_symbol = "[❯](red)";
            vimcmd_symbol = "[❮](green)";
          };

          directory = {
            truncation_length = 4;
            style = "bold pink";
          };

          palette = "catppuccin_mocha";

          palettes.catppuccin_mocha = {
            rosewater = "#f5e0dc";
            flamingo  = "#f2cdcd";
            pink      = "#f5c2e7";
            mauve     = "#cba6f7";
            red       = "#f38ba8";
            maroon    = "#eba0ac";
            peach     = "#fab387";
            yellow    = "#f9e2af";
            green     = "#a6e3a1";
            teal      = "#94e2d5";
            sky       = "#89dceb";
            sapphire  = "#74c7ec";
            blue      = "#89b4fa";
            lavender  = "#b4befe";
            text      = "#cdd6f4";
            subtext1  = "#bac2de";
            subtext0  = "#a6adc8";
            overlay2  = "#9399b2";
            overlay1  = "#7f849c";
            overlay0  = "#6c7086";
            surface2  = "#585b70";
            surface1  = "#45475a";
            surface0  = "#313244";
            base      = "#1e1e2e";
            mantle    = "#181825";
            crust     = "#11111b";
          };
        };
      };
    };
  };
}

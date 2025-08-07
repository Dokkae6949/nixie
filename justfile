# Show recipe list as help by default.
default:
    @just --list

# Rebuilds the NixOS system configuration.
rebuild-system host='':
    scripts/rebuild-system.sh {{host}}

# Rebuilds the Home-Manager user configuration.
rebuild-home:
    scripts/rebuild-home.sh

# Rebuilds both the home and the system configuration in that order.
rebuild-all:
    just rebuild-home
    just rebuild-system

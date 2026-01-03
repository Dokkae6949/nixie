{
	description = "System confiurations of Kurisu";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		flake-parts.url = "github:hercules-ci/flake-parts";

		# Hardware and storage configuration
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		impermanence.url = "github:nix-community/impermanence";
		disko = {
		  url = "github:nix-community/disko/latest";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Secrets management
		sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
		};
		secrets = {
      url = "git+ssh://git@github.com/Dokkae6949/nixowos-secrets.git?ref=main&shallow=1";
      flake = false;
    };

		# Desktop Components
		niri.url = "github:sodiboo/niri-flake?rev=30374d29ee04aca07f0384c2c664dea9487c0feb";
		nwww = {
			url = "github:Dokkae6949/nwww";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		quickshell = {
			url = "github:quickshell-mirror/quickshell";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		matugen = {
	    url = "github:InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
	  };

		# Application runner
		walker = {
			url = "github:abenz1267/walker";
			# inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, flake-parts, ... } @ inputs: let
		inherit (self) outputs;
	in
		flake-parts.lib.mkFlake { inherit inputs; } {
			imports = [
				inputs.flake-parts.flakeModules.easyOverlay
				inputs.home-manager.flakeModules.home-manager
			];

			# System which the "perSystem" will build for.
			systems = [
				"x86_64-linux"
				"x86_64-darwin"
				"aarch64-linux"
				"aarch64-darwin"
				"i686-linux"
			];

			# Runs once per above defined system.
			perSystem = { config, pkgs, ... }: {
				packages = import ./pkgs pkgs;

				devShells.default = pkgs.mkShell {
					packages = with pkgs; [
						just
					];
				};
			};
			
			# All flake configuration attributes go here.
			flake = {
				# Custom packages, modifications and extra nixpkg definitions.
				overlays = import ./overlays { inherit inputs; };
			
			  # NixOS configuration entrypoint.
        # Available through: 'nixos-rebuild --flake .#hostname'
				nixosConfigurations = {
					evergarden = inputs.nixpkgs.lib.nixosSystem {
						specialArgs = { inherit inputs outputs; };
						modules = [
							./hosts/evergarden/system/configuration.nix
						];
					};
				};

				# Standalone home-manager configuration entrypoint.
        # Available through: 'home-manager --flake .#username@hostname'
				homeConfigurations = {
					"kurisu@evergarden" = inputs.home-manager.lib.homeManagerConfiguration {
						pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
						extraSpecialArgs = { inherit inputs outputs; };
						modules = [
							./hosts/evergarden/homes/kurisu/home.nix
						];
					};
				};

				# Reusable nixos modules one might want to export.
				# Usually bundled pre-configured configuration toggles for my systems.
				nixosModules = import ./modules/nixos;
				# Reusable home-manager modules one might want to export.
				# Usually bundled pre-configured configuration toggles for my homes.
				homeManagerModules = import ./modules/home-manager;
			};
		};
}

{
  description = "Zoki workbook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, darwin, nixpkgs, home-manager, ... }:
  let
    nixpkgsConfig = {
      allowUnfree = true;
      allowUnsupportedSystem = false;
    };
    overlays = with inputs; [ ];
    user = "jh";
    hostname = "jh-mbp";
    system = "aarch64-darwin";
  in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
      # nix-darwin with home-manager for macOS
      darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
        inherit system;
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          inputs.nix-index-database.darwinModules.nix-index
          ./darwin
          ({ pkgs, inputs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;
            system = {
              stateVersion = 4;
              configurationRevision = self.rev or self.dirtyRev or null;
            };

            users.users.${user} = {
              home = "/Users/${user}";
              shell = pkgs.zsh;
            };

            networking = {
              computerName = hostname;
              hostName = hostname;
              localHostName = hostname;
            };

            nix = {
              # enable flakes per default
              useDaemon = true;
              package = pkgs.nixFlakes;
              gc = {
                automatic = false;
                user = user;
              };
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
                warn-dirty = false;
                # produces linking issues when updating on macOS
                # https://github.com/NixOS/nix/issues/7273
                auto-optimise-store = false;
              };
            };
          })
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = {
                inherit inputs;
              };
              users.${user} = { ... }:
                with inputs; {
                  imports = [ ./home-manager ./shell ];
                  home.stateVersion = "24.05";
                };
            };
          }
        ];
      };
    };
}
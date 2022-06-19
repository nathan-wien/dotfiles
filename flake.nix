{
  description = "by Nathan Nguyen";
  
  inputs = {
    # Package sets
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    # nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          neovim-nightly-overlay.overlay
        ];
      };
    in {
      nixosConfigurations = {
        nix-vm = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./nix/vm/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nhat = {
                imports = [ ./nix/vm/home.nix ];
              };
            }
          ];
        };
        personal-laptop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./nix/personal-laptop/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nhat = {
                imports = [ ./nix/personal-laptop/home.nix ];
              };
            }
          ];
        };
      };
      # homeConfigurations = {
      #   nix-vm = home-manager.lib.homeManagerConfiguration {
      #     inherit system pkgs;
      #     username = "nhat";
      #     homeDirectory = "/home/nhat";
      #     configuration = {
      #       imports = [
      #         ./home.nix
      #       ];
      #     };
      #   };
      # };
    };
}

{
  description = "NixOS configuration for bobini (self-contained flake)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rhythmgame.url = "github:bobini1/rhythmgame";
#   wsl = {
#     url = "github:nix-community/NixOS-WSL";
#     inputs.nixpkgs.follows = "nixpkgs";
#   };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    plasma-manager = {
      url = "github:nix-community/plasma-manager/trunk";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
#   wsl,
    nix-colors,
    emacs-overlay,
    nixpkgs-f2k,
    rhythmgame,
    plasma-manager,
    ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    username = "bobini";
    e-mail = "tomasz.kalisiak3@gmail.com";
    default-overlays = {
      nixpkgs.overlays = [
        emacs-overlay.overlay
        nixpkgs-f2k.overlays.window-managers
      ];
    };
  in
  {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs username;
          };
          modules = [
            ./hosts/pc
            default-overlays
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix # TODO Configure stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bak";
                sharedModules = [ plasma-manager.homeModules.plasma-manager
                                  inputs.nix-doom-emacs-unstraightened.homeModule ];
                extraSpecialArgs = {
                  inherit
                    username
                    nix-colors
                    inputs
                    e-mail
                    rhythmgame
                    ;
                };
              };
              home-manager.users.${username}.imports = [ (import ./hosts/pc/home.nix) ];
            }
          ];
        };
      };
      devShells.${system}.default = pkgs.mkShell {
        NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
        packages = with pkgs; [
          alejandra
          nixfmt-rfc-style
          git
          sops
          age
          deadnix
          nixd
          statix
        ];
        name = "dotfiles";
        shellHook = ''
          export FLAKE=$(pwd)
        '';
        DIRENV_LOG_FORMAT = "";
        formatter = pkgs.nixfmt-rfc-style;
      };
      devShells.${system}.java17 = pkgs.mkShell {
        NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
        packages = with pkgs; [
          openjdk17
        ];
        name = "java17";
      };
  };
}	

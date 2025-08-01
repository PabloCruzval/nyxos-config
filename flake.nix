{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }@inputs: {
    nixosConfigurations = {
      # Configuración para notebook ASUS
      nyx-asus = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/notebook.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };
      
      # Configuración para desktop PC Master Race
      nyx-pcmasterrace = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/desktop.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };
      
      # Mantener la configuración actual como fallback
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };
    };
  };
}

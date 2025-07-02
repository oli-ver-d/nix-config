{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    cbr-to-cbz.url = "github:oli-ver-d/cbr-to-cbz";
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/laptop-configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.dell-xps-15-9510
        inputs.nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
      ];
    };
  };
}

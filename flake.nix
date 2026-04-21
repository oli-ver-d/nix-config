{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    cbr-to-cbz.url = "github:oli-ver-d/cbr-to-cbz";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);

  # outputs = {
  #   self,
  #   nixpkgs,
  #   ...
  # } @ inputs: {
  #   nixosConfigurations.xps = nixpkgs.lib.nixosSystem {
  #     specialArgs = {inherit inputs;};
  #     modules = [
  #       ./hosts/xps/configuration.nix
  #       inputs.home-manager.nixosModules.default
  #       # inputs.nixos-hardware.nixosModules.dell-xps-15-9510
  #       # inputs.nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
  #     ];
  #   };
  #   nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
  #     specialArgs = {inherit inputs;};
  #     modules = [
  #       ./hosts/wsl/configuration.nix
  #       inputs.home-manager.nixosModules.default
  #       inputs.nixos-wsl.nixosModules.wsl
  #       # inputs.nixos-hardware.nixosModules.dell-xps-15-9510
  #       # inputs.nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
  #     ];
  #   };
  # };
}

{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.xps = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.xpsConfiguration
      self.nixosModules.myHomeManager
    ];
  };
}

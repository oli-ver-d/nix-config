{
  self,
  inputs,
  ...
}: {
  flake.homeModules.noctalia = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs.noctalia-shell = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;
    };
  };
}

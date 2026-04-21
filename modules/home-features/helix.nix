{
  self,
  inputs,
  ...
}: {
  flake.homeModules.helix = {
    pkgs,
    lib,
    ...
  }: {
    programs.helix = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHelix;
    };
  };
}

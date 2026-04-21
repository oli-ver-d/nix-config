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
    programs.noctalia-shell = {
      enable = true;
    };
  };
}

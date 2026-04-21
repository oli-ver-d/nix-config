{
  self,
  inputs,
  ...
}: {
  flake.homeModules.kitty = {pkgs, ...}: {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      enableGitIntegration = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty;
    };
  };
}

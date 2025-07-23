{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../../common/base/default.nix
    inputs.home-manager.nixosModules.default
  ];

  wsl.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "hitec" = import ./home/home.nix;
    };
  };

  home-manager.backupFileExtension = "backup";

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];
}

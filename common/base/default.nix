{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hitec = {
    isNormalUser = true;
    description = "Hitec Splash";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "uk";

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Allow random installs
  programs.nix-ld.enable = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  nixpkgs.config.packageOverrides = pkgs: {
    todo-cli = pkgs.callPackage ../../customnix/todo-cli.nix {};
  };

  environment.systemPackages = with pkgs; [
    vim
    fastfetch
    wget
    rustup
    gcc # needed for rust to compile
    python313
    ripgrep
    bat
    fzf
    htop
    jaq
    unzip
    zip
    luajit
    alejandra
    nixd
    monero-cli
    todo-cli
    mask
  ];
}

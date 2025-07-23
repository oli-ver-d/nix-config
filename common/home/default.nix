{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./helix.nix
    ./zsh.nix
  ];

  home.username = "hitec";
  home.homeDirectory = "/home/hitec";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    nushell
    eza
  ];

  home.file = {
    ".config/nvim".source = ./nvchad/starter;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    sourcebash = "source ~/.bashrc";
    la = "ls -a";
    cls = "clear";
    ff = "fastfetch";
  };

  programs.git = {
    enable = true;
    userEmail = "oliver.d.333@proton.me";
    userName = "Oliver Dennis";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    options = ["--cmd cd"];
  };

  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ps.magick];
    extraPackages = [pkgs.imagemagick];
  };

}

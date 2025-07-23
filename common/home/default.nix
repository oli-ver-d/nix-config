{
  config,
  pkgs,
  ...
}: {
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      sourcebash = "source ~/.bashrc";
      la = "ls -a";
      cls = "clear";
      ff = "fastfetch";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "eza" "rust"];
      theme = "robbyrussell";
    };
  };

  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ps.magick];
    extraPackages = [pkgs.imagemagick];
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      editor = {
        bufferline = "multiple";
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "hint";
        };
        cursor-shape.insert = "underline";
        lsp.display-inlay-hints = true;
      };
    };
  };
}

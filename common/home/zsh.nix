{...}: {
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
}

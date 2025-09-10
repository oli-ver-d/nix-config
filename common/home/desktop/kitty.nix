{...}: {
  programs.kitty = {
    enable = true;
    font.name = "DejaVu Mono Nerd Font";
    settings = {
      font_size = "12.0";
      window_padding_width = "10.0 10.0";
      margin_width = "0.0";
      background_opacity = "0.5";
      allow_remote_control = "yes";
      dynamic_background_opacity = "yes";
    };
    themeFile = "tokyo_night_night";
    shellIntegration.enableZshIntegration = true;
    enableGitIntegration = true;
  };
}

{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hitec";
  home.homeDirectory = "/home/hitec";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    wlr-randr
    wayland-utils
    rofi-wayland
    vbam
    nushell
  ];
  programs.home-manager.enable = true;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/nvim".source = "${config.home.homeDirectory}/dotfiles/nvchad/starter";
    ".config/rofi/config.rasi".source = "${config.home.homeDirectory}/dotfiles/rofi/config.rasi";
    ".config/mako/config".source = "${config.home.homeDirectory}/dotfiles/mako/config";
    ".config/hypr".source = "${config.home.homeDirectory}/dotfiles/hyprland";
    ".config/waybar".source = "${config.home.homeDirectory}/dotfiles/waybar";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hitec/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # theming
  qt.enable = true;

  qt.platformTheme.name = "kde";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  gtk.enable = true;

  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.theme.name = "adw-gtk3-dark";
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.iconTheme.name = "Adwaita";
  gtk.iconTheme.package = pkgs.adwaita-icon-theme;

  programs.bash.enable = true;

  programs.bash.shellAliases = {
    sourcebash = "source ~/.bashrc";
    la = "ls -a";
    jq = "jaq";
    fzv = "vim \$(fzf)";
    nixbuild = "sudo nixos-rebuild switch --impure --flake .#default";
    shutdownh = "sudo shutdown -h now";
    rebooth = "sudo reboot -h now";
    tb = "~/dotfiles/kitty_background.sh";
    cls = "clear";
    ff = "fastfetch";
  };

  programs.bash.initExtra = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/hitec/.local/share/flatpak/exports/share
    export PATH=$PATH:/home/hitec/.cargo/bin
    nvim() { kitty @ set-spacing padding=0; command nvim "$@"; kitty @ set-spacing padding=10; }
    hx() { kitty @ set-spacing padding=0; command hx "$@"; kitty @ set-spacing padding=10; }
    cda() { cd "$(active-cd)"; }
  '';

  programs.git = {
    enable = true;
    userEmail = "oliver.d.333@proton.me";
    userName = "Oliver Dennis";
  };

  programs.kitty = {
    enable = true;
    font.name = "Hack Nerd Font";
    settings = {
      font_size = "12.0";
      window_padding_width = "10.0 10.0";
      margin_width = "0.0";
      background_opacity = "0.5";
      allow_remote_control = "yes";
      dynamic_background_opacity = "yes";
    };
    themeFile = "tokyo_night_night";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = ["--cmd cd"];
  };

  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ps.magick];
    extraPackages = [pkgs.imagemagick];
  };

  programs.helix = {
    enable = true;
  };
}

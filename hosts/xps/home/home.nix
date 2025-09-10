{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../../common/home/default.nix
    ../../../common/home/desktop/kitty.nix
  ];

  home.packages = with pkgs; [
    wlr-randr
    wayland-utils
    rofi-wayland
    vbam
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/mako/config".source = ./mako/config;
    ".config/hypr".source = ./hyprland;
    ".config/waybar".source = ./waybar;
    ".config/rofi".source =
      pkgs.fetchFromGitHub {
        owner = "oli-ver-d";
        repo = "rofi";
        rev = "565ccfb4b27cbb435f307dc75c009b7b91311c4b";
        hash = "sha256-RxLzLcwlOrW6Iv7ay4ftrT6wBE3Nw6oFEIMjX2o/uuk=";
      }
      + "/packed";
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

  programs.bash.shellAliases = {
    jq = "jaq";
    fzv = "vim \$(fzf)";
    shutdownh = "sudo shutdown -h now";
    rebooth = "sudo reboot -h now";
    tb = "~/dotfiles/scripts/kitty_background.sh"; # FIX TO IMMUTABLE!
  };

  programs.bash.initExtra = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/hitec/.local/share/flatpak/exports/share
    export PATH=$PATH:/home/hitec/.cargo/bin
    nvim() { kitty @ set-spacing padding=0; command nvim "$@"; kitty @ set-spacing padding=10; }
    hx() { kitty @ set-spacing padding=0; command hx "$@"; kitty @ set-spacing padding=10; }
    cda() { cd "$(active-cd)"; }
  '';

  programs.zsh = {
    shellAliases = {
      jq = "jaq";
      fzv = "hx \$(fzf)";
      shutdownh = "sudo shutdown -h now";
      rebooth = "sudo reboot -h now";
      tb = "~/dotfiles/scripts/kitty_background.sh";
      mc = "curl https://am.i.mullvad.net/connected";
      sd = "systemctl poweroff";
      rb = "systemctl reboot";
      sl = "systemctl suspend";
    };

    initContent = ''
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/hitec/.local/share/flatpak/exports/share
      export PATH=$PATH:/home/hitec/.cargo/bin
      nvim() { kitty @ set-spacing padding=0; command nvim "$@"; kitty @ set-spacing padding=10; }
      hx() { kitty @ set-spacing padding=0; command hx "$@"; kitty @ set-spacing padding=10; }
      todo-cli ls
    '';
  };

  programs.obsidian.enable = true;

  services.spotifyd.enable = true;
  services.spotifyd.settings = {
    global = {
      device_name = "hitec_music";
      device_type = "computer";
      zeroconf_port = 5354;
    };
  };
}

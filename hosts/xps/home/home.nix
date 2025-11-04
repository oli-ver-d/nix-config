{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../../common/home/default.nix
    ../../../common/home/desktop/kitty.nix
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb.layout = "gb";
          numlock = true;
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      outputs = {
        "eDP-1" = {
          position.x = 0;
          position.y = 0;
        };
        "DP-1" = {
          position.x = 1920;
          position.y = 0;
        };
      };

      layout = {
        always-center-single-column = true;
        center-focused-column = "on-overflow";
        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
        ];
        default-column-width = {proportion = 0.5;};
        focus-ring = {
          enable = true;
          width = 4;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
      };

      spawn-at-startup = [
        {argv = ["waybar"];}
      ];

      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
      in {
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+T".action = spawn "kitty";
        "Mod+D".action = spawn "~/.config/rofi/launcher.sh";
        "Super+Alt+L".action = spawn "hyprlock";
        "XF86AudioRaiseVolume" = {
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          allow-when-locked = true;
        };

        "XF86AudioMute" = {
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = {
          action = sh "brightnessctl s 10%+";
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action = sh "brightnessctl s 10%-";
          allow-when-locked = true;
        };

        # Basic actions
        "Mod+O".action = toggle-overview;
        "Mod+Q".action = close-window;

        # Focus movement
        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-right;

        # Move windows
        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+L".action = move-column-right;

        # Home/End controls
        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        # Monitor focus
        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        # Move columns to monitors
        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        # Workspace focus and movement
        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;

        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        # Workspace indices
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;

        "Mod+Ctrl+1".action = move-column-to-index 1;
        "Mod+Ctrl+2".action = move-column-to-index 2;
        "Mod+Ctrl+3".action = move-column-to-index 3;
        "Mod+Ctrl+4".action = move-column-to-index 4;
        "Mod+Ctrl+5".action = move-column-to-index 5;
        "Mod+Ctrl+6".action = move-column-to-index 6;
        "Mod+Ctrl+7".action = move-column-to-index 7;
        "Mod+Ctrl+8".action = move-column-to-index 8;
        "Mod+Ctrl+9".action = move-column-to-index 9;

        # Column/window layout
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Ctrl+F".action = expand-column-to-available-width;

        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;

        # Size adjustments
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        # Floating / tiling
        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
        "Mod+W".action = toggle-column-tabbed-display;

        "Print".action = screenshot;
        # "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;

        "Mod+Escape" = {
          allow-inhibiting = false;
          action = toggle-keyboard-shortcuts-inhibit;
        };

        "Mod+Shift+E".action = quit;
        "Ctrl+Alt+Delete".action = quit;

        "Mod+Shift+P".action = power-off-monitors;
      };
    };
  };

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

  programs.alacritty.enable = true;

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

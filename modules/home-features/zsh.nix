{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zsh = {pkgs, ...}: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = ["git" "eza" "rust"];
        theme = "robbyrussell";
      };

      shellAliases = {
        la = "ls -a";
        cls = "clear";
        ff = "fastfetch";
        jq = "jaq";
        fzv = "hx \$(fzf --preview='bat --color=always {}')";
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
        weather() {
          local base="wttr.in"
          if [[ "$1" == "-v" ]]; then
            base="v2d.wttr.in"
            shift
          fi
          if [[ -n "$1" ]]; then
            curl "$base/$1"
          else
            local default_location
            default_location="$(<~/.weather)"
            curl "$base/$default_location"
          fi
        }
      '';
    };
  };
}

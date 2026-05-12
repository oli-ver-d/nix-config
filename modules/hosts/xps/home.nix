{
  self,
  inputs,
  ...
}: {
  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.hitec = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules.hitecModule
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.hitecModule = {pkgs, ...}: {
    imports = [
      self.homeModules.helix
      self.homeModules.kitty
      self.homeModules.noctalia
      self.homeModules.zsh
    ];
    home.username = "hitec";
    home.homeDirectory = "/home/hitec";

    home.stateVersion = "24.05";

    home.file = {
      ".config/hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
      ".config/hypr/start.sh".source = ./hyprland/start.sh;
    };

    programs.home-manager.enable = true;
    nixpkgs.config = {
      allowBroken = true;
      allowUnfree = true;
    };

    home.packages = with pkgs; [
      nushell
      eza
      wlr-randr
      wayland-utils
    ];

    home.sessionVariables = {
      EDITOR = "hx";
    };

    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "oliver.d.333@proton.me";
          name = "Oliver Dennis";
        };
        push.autoSetupRemote = true;
      };
      signing.format = "openpgp";
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
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

    services.spotifyd.enable = true;
    services.spotifyd.settings = {
      global = {
        device_name = "hitec_music";
        device_type = "computer";
        zeroconf_port = 5354;
      };
    };
  };
}

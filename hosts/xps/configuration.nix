# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common/base/default.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "loglevel=3"
  ];

  networking.hostName = "xps"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable the X11 windowing system.
  qt.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings = {
    General = {
      DefaultSession = "hyprland.desktop";
    };
  };

  services.displayManager.sddm.theme = "${import ../../customnix/sddm-theme.nix {inherit pkgs;}}";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };

  hardware.nvidia = {
    powerManagement.enable = true;
    open = true; # Use proprietary drivers; set to true for open-source (if supported)
    nvidiaSettings = true; # Installs the NVIDIA settings application
  };

  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.extraConfig."99-disable-suspend" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "node.name" = "~alsa_input.*";
            }
            {
              "node.name" = "~alsa_output.*";
            }
          ];
          actions = {
            update-props = {
              "session.suspend-timeout-seconds" = 0;
            };
          };
        }
      ];
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "hitec" = import ./home/home.nix;
    };
  };

  home-manager.backupFileExtension = "backup";

  # Install firefox.
  programs.firefox.enable = true;
  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    dejavu_fonts
  ];

  environment.systemPackages = with pkgs; [
    mullvad-browser
    vscode
    libreoffice
    hunspell
    hunspellDicts.en_GB-ise
    signal-desktop
    bitwarden-desktop
    dolphin-emu
    tor-browser
    spotify
    zotero
    font-awesome
    calibre
    wl-clipboard
    jetbrains.rust-rover
    thunderbird
    pamixer
    ydotool
    pinentry-all
    waybar
    (
      waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      })
    )
    mako
    swww
    networkmanagerapplet
    kdePackages.qtwayland
    kdePackages.qtsvg
    kdePackages.dolphin
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    pavucontrol
    playerctl
    xorg.xcursorthemes
    hyprlock
    quickemu
    qemu
    hypridle
    brave
    brightnessctl
    monero-gui
    qbittorrent
    (inputs.cbr-to-cbz.packages.${pkgs.system}.default)
    komga
    slurp
    grim
    vlc
    kdePackages.kleopatra
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  nixpkgs.config.permittedInsecurePackages = [
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

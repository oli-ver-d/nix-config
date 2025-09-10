{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    dejavu_fonts
  ];
}

{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      font.name = "DejaVu Mono Nerd Font";
      extraPackages = with pkgs; [
        nerd-fonts.dejavu-sans-mono
      ];
      settings = {
        font_size = "12.0";
        window_padding_width = "10.0 10.0";
        margin_width = "0.0";
        background_opacity = "0.6";
        allow_remote_control = "yes";
        dynamic_background_opacity = "yes";
      };
      themeFile = "tokyo_night_night";
    };
  };
}

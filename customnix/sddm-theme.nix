{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "oli-ver-d";
    repo = "where-is-my-sddm-theme";
    rev = "20633a16267b22aab569853207bc35ddbb918f49";
    sha256 = "sha256-YozS8xLNdi/M3MZmSa6ufm1qW3B6MjnJMv+mjBsUnRM=";
  };
  installPhase = ''
    mkdir -p $out/share/sddm/themes/mytheme
    cp -R ./where_is_my_sddm_theme/* $out/share/sddm/themes/mytheme/
    cp ./where_is_my_sddm_theme/example_configs/classic_nocursor.conf $out/share/sddm/themes/mytheme/theme.conf
  '';
}

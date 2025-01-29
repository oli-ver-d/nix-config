{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "oli-ver-d";
    repo = "where-is-my-sddm-theme";
    rev = "92812814749d30d2159e3e00e5de5a96d2725d1f";
    sha256 = "sha256-gIJ8aD3Olpg/3oRzk4Ifz9saE4N4rRFZgD1o+lnuoag=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./where_is_my_sddm_theme_qt5/* $out/
    cp ./where_is_my_sddm_theme_qt5/example_configs/classic_nocursor.conf $out/theme.conf
  '';
}

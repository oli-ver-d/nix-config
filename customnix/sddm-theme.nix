
{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "stepanzubkov";
    repo = "where-is-my-sddm-theme";
    rev = "f9a49dd80c8a30967b77ed784eb2312a02fabcf1";
    sha256 = "PMQ2geMSE8H0K3HtvaowzJfS+k0mHSAQeJ9A5G9+rLY=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./where_is_my_sddm_theme_qt5/* $out/
    cp ./where_is_my_sddm_theme_qt5/example_configs/grey.conf $out/theme.conf
  '';
}

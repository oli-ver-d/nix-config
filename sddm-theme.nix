
{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "stepanzubkov";
    repo = "where-is-my-sddm-theme";
    rev = "f9a49dd80c8a30967b77ed784eb2312a02fabcf1";
    hash = "1g91vqrmwprh2cch6fhwm2ma9j1agb7y1am1pax3mf3ampw3srll";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./where_is_my_sddm_theme_qt5/* $out/
  '';
}

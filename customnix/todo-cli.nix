{ stdenv, lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "todo-cli";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "oli-ver-d";
    repo = pname;
    rev = "d4dc83522f209bac2cd7103a934dfc6930d8b12e";
    hash = "sha256-xLxFVo3vrqaXU0Rc4XgKbWuuF1fEI40ujdFBGT7U9RI=";
  };

  cargoHash = "sha256-Oev0/2tcrFUG156A7EORqr24kgZF68nhiw7Odjg11hY=";

  meta = with lib; {
    description = "Cli todo list";
    homepage = "https://github.com/oli-ver-d/todo-cli";
    licence = licenses.mit;
    platforms = platforms.unix;
  };
}

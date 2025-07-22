{ stdenv, lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "todo-cli";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "oli-ver-d";
    repo = pname;
    rev = "e829a88253255d2788203386647698451c2902c6";
    hash = "sha256-3c9HOlWLwmX+jJ1g9yp4+P2gT8xJpb3M8GbjoAmPdCI=";
  };

  cargoHash = "sha256-liTYWnN8zA4BMSfLSDi7+ICiDZeKLe2XuaOT7Y9uENs=";

  meta = with lib; {
    description = "Cli todo list";
    homepage = "https://github.com/oli-ver-d/todo-cli";
    licence = licenses.mit;
    platforms = platforms.unix;
  };
}

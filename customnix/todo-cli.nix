{ stdenv, lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "todo-cli";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "oli-ver-d";
    repo = pname;
    rev = "c8a71d62671472aa943415822d79c3dbf84de854";
    hash = "sha256-33MWUvGlgDU6mWHNkVsDN9IykFb7s0I3TpZ1c/0x2Wo=";
  };

  cargoHash = "sha256-liTYWnN8zA4BMSfLSDi7+ICiDZeKLe2XuaOT7Y9uENs=";

  meta = with lib; {
    description = "Cli todo list";
    homepage = "https://github.com/oli-ver-d/todo-cli";
    licence = licenses.mit;
    platforms = platforms.unix;
  };
}

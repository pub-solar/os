{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "futura";
  version = "1.0.0";

  src = ../secrets/fonts/Futura Std;

  installPhase = ''
    install -D -m 444 /* -t $out/share/fonts/otf
  '';

  meta = with stdenv.lib; {
    description = "";
    longDescription = ''
    '';
    homepage = "";
  };
}

{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "futura";
  version = "1.0.0";

  src = ../../secrets/fonts/Futura_Std;

  installPhase = ''
    mkdir -p $out/share/fonts/otf/
    cp -r * $out/share/fonts/otf/
  '';

  meta = with stdenv.lib; {
    description = "";
    longDescription = ''
    '';
    homepage = "";
  };
}

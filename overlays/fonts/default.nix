final: prev:
with final; {
  futura-otf = import ./futura.nix { stdenv = final.stdenv; fetchFromGitHub = final.fetchFromGitHub; };
}

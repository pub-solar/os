{ suites, ... }:
{
  imports = [
    ./biolimo.nix
  ] ++ suites.biolimo;
}

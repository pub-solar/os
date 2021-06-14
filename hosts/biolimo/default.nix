{ suites, ... }:
{
  imports = [
    ./base.nix
  ] ++ suites.biolimo;
}

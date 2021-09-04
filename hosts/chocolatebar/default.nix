{ suites, ... }:
{
  imports = [
    ./chocolatebar.nix
  ] ++ suites.chocolatebar;
}

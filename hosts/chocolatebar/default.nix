{ suites, ... }:
{
  imports = [
    ./base.nix
  ] ++ suites.chocolatebar;
}

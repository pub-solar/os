{ suites, ... }:
{
  imports = [
    ./chocolatebar
  ] ++ suites.chocolatebar;
}

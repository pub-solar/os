{ suites, ... }:
{
  imports = [
    ./biolimo
  ] ++ suites.biolimo;
}

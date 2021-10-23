let
  # set ssh public keys here for your system and user
  bbcom = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmXpOU6vzQiVSSYCoxHYv7wDxC63Qg3dxlAMR6AOzwIABCU5PFFNcO0NWYms/YR7MOViorl+19LCLRABar9JgHU1n+uqxKV6eGph3OPeMp5sN8LAh7C9N+TZj8iJzBxQ3ch+Z/LdmLRwYNJ7KSUI+gwGK6xRS3+z1022Y4P0G0sx7IeCBl4lealQEIIF10ZOfjUdBcLQar7XTc5AxyGKnHCerXHRtccCoadLQujk0AvPXbv3Ma4JwX9X++AnCWRWakqS5UInu2tGuZ/6Hrjd2a9AKWjTaBVDcbYqCvY4XVuMj2/A2bCceFBaoi41apybSk26FSFTU4qiEUNQ6lxeOwG4+1NCXyHe2bGI4VyoxinDYa8vLLzXIRfTRA0qoGfCweXNeWPf0jMqASkUKaSOH5Ot7O5ps34r0j9pWzavDid8QeKJPyhxKuF1a5G4iBEZ0O9vuti60dPSjJPci9oTxbune2/jb7Sa0yO06DtLFJ2ncr5f70s/BDxKk4XIwQLy+KsvzlQEGdY8yA6xv28bOGxL3sQ0HE2pDTsvIbAisVOKzdJeolStL9MM5W8Hg0r/KkGj2bg0TfoRp1xHV9hjKkvJrsQ6okaPvNFeZq0HXzPhWMOVQ+/46z80uaQ1ByRLr3FTwuWJ7F/73ndfxiq6bDE4z2Ji0vOjeWJm6HCxTdGw== hello@benjaminbaedorf.com";

  biolimo-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBZzg8pfVtFonx/IvO2MKG5uVF/sMJAOt1Ifm9Vds2eA root@biolimo";
  biolimo-user = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDoYNvXWunQYFORRjcYH1F98+zr20U79ROh+gmaC7AY/x3yf4y8uyMayF56VgQLVNwgEchT5t4dNb9qo2+1oUnjiKrKAVfQMN6WMMMEr4F4WT784uvBx5Uo6vmhgAa+xoo62c4TV2Uf49ZiPd+zAApBHW1F/whPtunPF28Wfr9g+ozSidhnAr+3nkfJh331tz9s+wgQ39AFzFWftQ60Guulpfj8SaVyxyv/yZZAuFpXNzN0Cz4fWBIWFOsib6Z8y+SlUCzSzOguZ7FygHjwlvOxoISsASAuf0OfUKHxVshiL5F5AX1ddmUgXbUKUTp/3Iunr74pfOQC8TXzZHqhrlFzYDmK5J9E6eADSpgx++bCCaHycl73BWeertCBZSHBXeb3Db9HX+mxwpfP3alVAt4ZqQb3YD/VB7XGDvHbmLn+wSfecO2qA9PxiA0yX7e2BZLN9r3G3bRNSk0GpnYM0i84FE9IipiKKnWVjj7J0UPQmz7rzAn2Lki1CnX9PDdxZneqTxgpBomHJt4H+vXMw13scA4xxEDBvfS5KkjbEJqWLbfklCoER6nV3NPLZ6CBl0Xe/VQBSkqEuUEIXih/oa8emDOGUODNF75ck5NJmKiGg6AFZoeiDa7PZMIxhhOq4vsR2Ty43rztUJ0CMX7iSIk3Eql7kqNdvrJaJ7z0GBsiw== ben@biolimo";

  chocolatebar-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINZT3QrKugNTWNOwYziQnxrT5zFqWQDafWjScDuIpMhN root@chocolatebar";
  chocolatebar-user = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDwyNsGCMuyI9x2IxYEbYIL6oYsEfe1wqhHaRxSnK9oc10ge1LJni5o7g6XgryoQpCD9YenImcCxwkKblmlLQ2327uoVC2PUo07li1uT0eIPk0TQoxwp6besFs7/LEzZlgWQsc3gkEXmjk/E0mu0U6z2fkqciJ/ZxWYt9fLP6jBG47U9878rSaZ7k7Ilv6oRA3suArH189k1nerk/tonS4EWXeHZxHh/Eu0tqwmxN/6+g2GicYn6b+MbFQVdQAkctqT5Yz9USm9UKzbaAuZ799u0dJzagHm9JJZOr8r11ENtAkY9kAzRzm3u/ACiSdVzyLdjAK6m0dIPhp3OhedzuHiI6/wRll60tYtQTH1XwUpVbtir3+DT+jwZgO1zH3yL4iNh79kuUo+UEg1ZmGkSZRzSS2vb5qr0J5aSJmCd5sNB7a01PTtSlQPOqSF9PB+UmcLDF7JoKFub0KT/gRZ5neZkXTYQ/Y05qtaaFVlOVISijnm+sLUvKBv6OW8oYXIHBk= ben@chocolatebar";

  allKeys = [
    bbcom

    biolimo-host
    biolimo-user

    chocolatebar-host
    chocolatebar-user
  ];

  biolimoKeys = [
    bbcom

    biolimo-host
    biolimo-user
  ];

  chocolatebarKeys = [
    bbcom

    chocolatebar-host
    chocolatebar-user
  ];
in
{
  "keyfile-biolimo.bin".publicKeys = biolimoKeys;

  "keyfile-chocolatebar.bin".publicKeys = chocolatebarKeys;
  "crypto_keyfile-chocolatebar.bin".publicKeys = chocolatebarKeys;
  "hdd_keyfile-chocolatebar.bin".publicKeys = chocolatebarKeys;

  "mopidy.conf".publicKeys = allKeys;
}

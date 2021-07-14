{ config, pkgs, lib, ... }:
let
  psCfg = config.pub-solar;
in
{
  imports = [
    ./home.nix
  ];

  config = {
    pub-solar = {
      # These are your personal settings
      # The only required settings are `name` and `password`,
      # The rest is used for programs like git
      user = {
        name = "ben";
        password = "$6$LO2YoaHwuRQhUoSz$iHw9avM887eJg9cIty2nmG4Ibkol3YpviEhYpivVQP31VrnihFz/6LyugxD7X4VmXx9nxvcYIZnN90rlGxwjT.";
        fullName = "Benjamin Bädorf";
        email = "hello@benjaminbaedorf.eu";
        gpgKeyId = "4406E80E13CD656C";
      };

      email.enable = true;
      uhk.enable = true;
    };

    networking.hosts = {
      "127.0.0.1" = [
        "openproject.local"
        "saas-1.openproject.local"
        "transmission.local"
      ];
    };

    fonts.fonts = lib.attrValues pkgs.b12f.fonts;
  };
}

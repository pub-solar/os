{ hmUsers, ... }:
{
  home-manager.users = { inherit (hmUsers) pub-solar; };

  pub-solar = {
    # These are your personal settings
    # The only required settings are `name` and `password`,
    # for convenience, use publicKeys to add your SSH keys
    # The rest is used for programs like git
    user = {
      name = "pub-solar";
      # default password = pub-solar
      password = "$6$Kv0BCLU2Jg7GN8Oa$hc2vERKCbZdczFqyHPfgCaleGP.JuOWyd.bfcIsLDNmExGXI6Rnkze.SWzVzVS311KBznN/P4uUYAUADXkVtr.";
      fullName = "Pub Solar";
      email = "iso@pub.solar";
      publicKeys = [ ];
    };
  };
}

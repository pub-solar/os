{ config, pkgs, lib, ... }:

with lib;

let cfg = config.pub-solar.x-os;
in
{
  options.pub-solar.x-os = {
    binaryCaches = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Binary caches to use.";
    };
    publicKeys = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Public keys of binary caches.";
    };
    iwdConfig = mkOption {
      type = with types; nullOr (attrsOf (attrsOf (oneOf [ bool int str ])));
      default = null;
      description = "Configuration of iNet Wireless Daemon.";
    };
  };
  config = {
    networking.networkmanager = {
      # Enable networkmanager. REMEMBER to add yourself to group in order to use nm related stuff.
      enable = true;
    };

    # Customized binary caches list (with fallback to official binary cache)
    nix.binaryCaches = cfg.binaryCaches;
    nix.binaryCachePublicKeys = cfg.publicKeys;

    # These entries get added to /etc/hosts
    networking.hosts = {
      "127.0.0.1" = [ "cups.local" ];
    };

    # Caddy reverse proxy for local services like cups
    services.caddy = {
      enable = true;
      config = ''
        {
          auto_https off
        }
        cups.local:80
        bind 127.0.0.1
        request_header Host localhost:631
        reverse_proxy unix//run/cups/cups.sock
      '';
    };
  };
}

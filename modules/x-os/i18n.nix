{ config, pkgs, lib, ... }:
with lib;
{
  config = {
    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    console = {
      font = "Lat2-Terminus16";
    };
    i18n = {
      defaultLocale = "en_US.UTF-8";
    };
  };
}

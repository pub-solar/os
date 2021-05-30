pkgs: {
  enable = true;
  extensionPackages = with pkgs; [
    mopidy-spotify
    mopidy-mpd
    mopidy-soundcloud
    mopidy-youtube
    mopidy-local
    mopidy-jellyfin
  ];

  configuration = ''
    [mpd]
    hostname = ::

    [audio]
    output = pulsesink server=127.0.0.1:4713
  '';
}

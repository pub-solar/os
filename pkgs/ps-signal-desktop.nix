self: with self;
let
  signal-desktop = self.signal-desktop.overrideAttrs (old: {
    meta.platforms = [ "x86_64-linux" "aarch64-linux" ];
  });
in
''
  exec ${signal-desktop}/bin/signal-desktop --disable-gpu -- "$@"
''

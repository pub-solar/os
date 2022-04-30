self: with self;
let
  looking-glass-client = self.looking-glass-client.overrideAttrs (old: {
    meta.platforms = [ "x86_64-linux" "aarch64-linux" ];
  });
in
''
  ${looking-glass-client}/bin/looking-glass-client -f /dev/shm/looking-glass input:ignoreWindowsKeys=yes input:grabKeyboardOnFocus=no
''

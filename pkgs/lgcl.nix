self: with self; ''
  ${self.looking-glass-client}/bin/looking-glass-client -f /dev/shm/looking-glass input:ignoreWindowsKeys=yes input:grabKeyboardOnFocus=no input:rawMouse=yes
''

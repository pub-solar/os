self: with self; ''
  export PATH=${lib.makeBinPath [ pkgs.coreutils pkgs.sane-frontends pkgs.sane-backends pkgs.ghostscript pkgs.imagemagick ]}
''

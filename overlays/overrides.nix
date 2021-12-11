channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    cachix
    docker
    docker-compose_2
    dhall
    discord
    element-desktop-wayland
    rage
    docker-compose
    neovim-unwrapped
    nixpkgs-fmt
    qutebrowser
    signal-desktop
    tdesktop
    starship
    deploy-rs
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    obs-studio
    obs-studio-plugins
    looking-glass-client
    ;

  haskellPackages = prev.haskellPackages.override
    (old: {
      overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (hfinal: hprev:
        let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
        in
        {
          # same for haskell packages, matching ghc versions
          inherit (channels.latest.haskell.packages."ghc${version}")
            haskell-language-server;
        });
    });
}

channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    cachix
    dhall
    discord
    element-desktop
    rage
    nixpkgs-fmt
    qutebrowser
    signal-desktop
    starship
    deploy-rs

    nixUnstable
    neovim-unwrapped
    tdesktop
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    obs-studio
    obs-studio-plugins
    looking-glass-client
    nix-direnv
    vimPlugins
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

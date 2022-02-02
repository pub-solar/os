{ config, pkgs, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
  variables = {
    XDG_CONFIG_HOME = xdg.configHome;
    XDG_CACHE_HOME = xdg.cacheHome;
    XDG_DATA_HOME = xdg.dataHome;

    XDG_CURRENT_DESKTOP = "sway";

    QT_QPA_PLATFORM = "wayland";

    # Wayland fixes
    ECORE_EVAS_ENGINE = "wayland_egl";
    ELM_ENGINE = "wayland_egl";
    SDL_VIDEODRIVER = "wayland";

    EDITOR = "/etc/profiles/per-user/${psCfg.user.name}/bin/nvim";
    VISUAL = "/etc/profiles/per-user/${psCfg.user.name}/bin/nvim";

    # fix "xdg-open fork-bomb" your preferred browser from here
    BROWSER = "${pkgs.firefox-wayland}/bin/firefox";

    # node
    NODE_REPL_HISTORY = "${xdg.dataHome}/node_repl_history";
    NVM_DIR = "${xdg.dataHome}/nvm";
    PKG_CACHE_PATH = "${xdg.cacheHome}/pkg-cache";

    # npm
    NPM_CONFIG_USERCONFIG = "${xdg.configHome}/npm/config";
    NPM_CONFIG_CACHE = "${xdg.configHome}/npm";
    # TODO: used to be XDG_RUNTIME_DIR NPM_CONFIG_TMP = "/tmp/npm";

    # Make sure virsh runs without root
    LIBVIRT_DEFAULT_URI = "qemu:///system";

    # wine
    WINEPREFIX = "${xdg.dataHome}/wineprefixes/default";

    # z
    _Z_DATA = "${xdg.dataHome}/z";

    # wget
    WGETRC = "${xdg.configHome}/wgetrc";

    # rust
    RUSTUP_HOME = "${xdg.dataHome}/rustup";
    CARGO_HOME = "${xdg.dataHome}/cargo";

    # Java
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot='${xdg.configHome}/java'";
    _JAVA_AWT_WM_NONREPARENTING = "1";

    # docker
    DOCKER_CONFIG = "${xdg.configHome}/docker";

    # experimental wayland in firefox/thunderbird
    MOZ_ENABLE_WAYLAND = "1";

    # chromium / electron on wayland: enable ozone (native wayland mode)
    NIXOS_OZONE_WL = "1";

    # Vagrant
    VAGRANT_HOME = "${xdg.dataHome}/vagrant";
    VAGRANT_DEFAULT_PROVIDER = "libvirt";

    # Android
    ANDROID_SDK_ROOT = "${xdg.configHome}/android";

    ANDROID_AVD_HOME = "${xdg.dataHome}/android";
    ANDROID_EMULATOR_HOME = "${xdg.dataHome}/android";
    ADB_VENDOR_KEY = "${xdg.configHome}/android";

    # TELEMETRY BS
    VUEDX_TELEMETRY = "off";
  };
in
{
  home-manager = pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
    home.sessionVariables = variables;
    systemd.user.sessionVariables = variables;
  };
}

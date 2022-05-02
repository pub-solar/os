final: prev:
with final; {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) { };
  # then, call packages with `final.callPackage`
  import-gtk-settings = writeShellScriptBin "import-gtk-settings" (import ./import-gtk-settings.nix final);
  lgcl = writeShellScriptBin "lgcl" (import ./lgcl.nix final);
  mailto-mutt = writeShellScriptBin "mailto-mutt" (import ./mailto-mutt.nix final);
  mopidy-jellyfin = import ./mopidy-jellyfin.nix final;
  mu = writeShellScriptBin "mu" (import ./mu.nix final);
  psos = writeShellScriptBin "psos" (import ./psos.nix final);
  s = writeShellScriptBin "s" (import ./s.nix final);
  sway-launcher = writeScriptBin "sway-launcher" (import ./sway-launcher.nix final);
  sway-service = writeShellScriptBin "sway-service" (import ./sway-service.nix final);
  swaylock-bg = writeScriptBin "swaylock-bg" (import ./swaylock-bg.nix final);
  toggle-kbd-layout = writeShellScriptBin "toggle-kbd-layout" (import ./toggle-kbd-layout.nix final);
  uhk-agent = import ./uhk-agent.nix final;
  wcwd = writeShellScriptBin "wcwd" (import ./wcwd.nix final);
  # ps-fixes
  ps-signal-desktop = writeShellScriptBin "signal-desktop" (import ./ps-signal-desktop.nix final);

  scan2paperless = writeShellScriptBin "scan2paperless" (import ./scan2paperless.nix final);
  drone-docker-runner = writeShellScriptBin "drone-docker-runner" (import ./drone-docker-runner.nix final);
}

self: with self;
let
  uhk-agent-bin = stdenv.mkDerivation rec {
    pname = "uhk-agent-bin";
    version = "1.5.14";
    src = builtins.fetchurl {
      url = "https://github.com/UltimateHackingKeyboard/agent/releases/download/v1.5.14/UHK.Agent-1.5.14-linux-x86_64.AppImage";
      sha256 = "sha256:1yzh4ixy0cqg02xf84vcqj3h67mkxyzs6jf1h935ay582n70nyqg";
    };
    phases = [ "installPhase" "patchPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/uhk-agent
      chmod +x $out/bin/uhk-agent
    '';
  };

  script = ''
    #!${bash}/bin/bash

    ${appimage-run}/bin/appimage-run ${uhk-agent-bin}/bin/uhk-agent
  '';
in
stdenv.mkDerivation rec {
  pname = "uhk-agent";
  version = "1.5.14";
  buildInputs = [
    bash
    uhk-agent-bin
    appimage-run
  ];

  phases = [ "buildPhase" "installPhase" "patchPhase" ];

  buildPhase = ''
    echo "${script}" >> uhk-agent
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp uhk-agent $out/bin/uhk-agent
    chmod +x $out/bin/uhk-agent
  '';
}

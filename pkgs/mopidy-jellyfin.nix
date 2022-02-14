self: with self;
let
  websocket-client = python39.pkgs.buildPythonPackage rec {
    pname = "websocket-client";
    version = "1.2.1";
    doCheck = false;
    src = python39.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-jftxXYqZL1cS//jIQ62ulOIrIqmbLF5rDsShqYHMTg0=";
    };
  };
in
python39.pkgs.buildPythonPackage rec {
  pname = "Mopidy-Jellyfin";
  version = "1.0.2";
  doCheck = false;
  propagatedBuildInputs = with python39.pkgs; [
    unidecode
    websocket-client
    requests
    setuptools
    pykka
    mopidy
  ];
  src = python39.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-5XimIIQSpvNyQbSOFtSTkA0jhA0V68BbyQEQNnov+0g=";
  };
}

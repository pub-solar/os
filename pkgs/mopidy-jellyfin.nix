self: with self;
let
  websocket-client = python38.pkgs.buildPythonPackage rec {
    pname = "websocket-client";
    version = "1.0.0";
    doCheck = false;
    src = python38.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-UFGzii9MJ/vXygd+uyPsaWWmJt7VqVY382vhs1tsT4E=";
    };
  };
in
python38.pkgs.buildPythonPackage rec {
  pname = "Mopidy-Jellyfin";
  version = "1.0.2";
  doCheck = false;
  propagatedBuildInputs = with python38.pkgs; [
    unidecode
    websocket-client
    requests
    setuptools
    pykka
    mopidy
  ];
  src = python38.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-5XimIIQSpvNyQbSOFtSTkA0jhA0V68BbyQEQNnov+0g=";
  };
}

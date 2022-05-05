{ stdenv, lib, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "window-sigils";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "eraserhd";
    repo = pname;
    rev = "v${version}";
    sha256 = "";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    description = "Command-line utilities for managing Mac OS windows";
    homepage = "https://github.com/eraserhd/window-sigils";
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}

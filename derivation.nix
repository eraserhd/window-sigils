{ stdenv, lib, fetchFromGitHub, darwin }:

let
  inherit (darwin.apple_sdk.frameworks) CoreFoundation CoreGraphics;
in stdenv.mkDerivation rec {
  pname = "window-sigils";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "eraserhd";
    repo = pname;
    rev = "v${version}";
    sha256 = "";
  };

  buildInputs = [
    CoreFoundation
    CoreGraphics
  ];

  NIX_LDFLAGS = ''-F${CoreGraphics}/Library/Frameworks -framework CoreGraphics'';
  makeFlags = [ "prefix=$(out)" ];

  meta = with lib; {
    description = "Command-line utilities for managing Mac OS windows";
    homepage = "https://github.com/eraserhd/window-sigils";
    license = licenses.publicDomain;
    platforms = platforms.darwin;
    maintainers = [ maintainers.eraserhd ];
  };
}

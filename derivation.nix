{ stdenv, lib, darwin }:

let
  inherit (darwin) libobjc;
  inherit (darwin.apple_sdk.frameworks) AppKit CoreFoundation CoreGraphics;
in stdenv.mkDerivation rec {
  pname = "window-sigils";
  version = "0.1.0";

  src = ./.;

  buildInputs = [
    libobjc
    CoreFoundation
    CoreGraphics
  ];

  NIX_LDFLAGS = "-F${AppKit}/Library/Frameworks -F${CoreGraphics}/Library/Frameworks";
  makeFlags = [ "prefix=$(out)" ];

  meta = with lib; {
    description = "Command-line utilities for managing Mac OS windows";
    homepage = "https://github.com/eraserhd/window-sigils";
    license = licenses.publicDomain;
    platforms = platforms.darwin;
    maintainers = [ maintainers.eraserhd ];
  };
}

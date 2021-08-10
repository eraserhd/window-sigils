{ nixpkgs ? (import ./nixpkgs.nix), ... }:
let
  pkgs = import nixpkgs {
    config = {};
    overlays = [
      (import ./overlay.nix)
    ];
  };
in {
  test = pkgs.runCommandNoCC "window-sigils-test" {} ''
    mkdir -p $out
    : ${pkgs.window-sigils}
  '';
}
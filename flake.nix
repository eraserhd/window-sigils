{
  description = "TODO: fill me in";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        window-sigils = pkgs.callPackage ./derivation.nix {};
      in {
        packages = {
          default = window-sigils;
          inherit window-sigils;
        };
        checks = {
          test = pkgs.runCommandNoCC "window-sigils-test" {} ''
            mkdir -p $out
            : ${pkgs.window-sigils}
          '';
        };
    })) // {
      overlays.default = final: prev: {
        window-sigils = prev.callPackage ./derivation.nix {};
      };
    };
}

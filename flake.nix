{
  description = "Keyboard access to focus and arrange mostly-tiled windows";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachSystem ["x86_64-darwin"] (system:
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
            : ${window-sigils}
          '';
        };
    })) // {
      overlays.default = final: prev: {
        window-sigils = prev.callPackage ./derivation.nix {};
      };
    };
}

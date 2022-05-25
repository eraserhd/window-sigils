{
  description = "Keyboard access to focus and arrange mostly-tiled windows";
  inputs = {};
  outputs = { self, nixpkgs, flake-utils }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-darwin;
      window-sigils = pkgs.callPackage ./derivation.nix {};
    in {
      packages.x86_64-darwin = {
        default = window-sigils;
        inherit window-sigils;
      };
      checks.x86_64-darwin = {
        test = pkgs.runCommandNoCC "window-sigils-test" {} ''
          mkdir -p $out
          : ${window-sigils}
        '';
      };
      overlays.default = final: prev: {
        window-sigils = prev.callPackage ./derivation.nix {};
      };
      darwinModules.default = { pkgs, ... }: {
        config = {
          nixpkgs.overlays = [ self.overlays.default ];

          environment.systemPackages = [ pkgs.window-sigils ];
        };
      };
    };
}

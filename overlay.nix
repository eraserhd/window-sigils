self: super: {
  window-sigils = super.callPackage ./derivation.nix {
    fetchFromGitHub = _: ./.;
  };
}

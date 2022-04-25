{
  description = "My texmf flake, with bibliography and sty files.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          defaultPackage = pkgs.stdenv.mkDerivation {
            pname = "texmf";
            version = "0.0.1";
            dontConfigure = true;
            src = ./.;
            installPhase = ''
                         cp -r tex/ $out
                         cp -r bibtex/ $out
                           '';
          };
        }
    );
}

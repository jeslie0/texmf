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
          defaultPackage = self.packages.${system}.texmf;

          packages.texmf = pkgs.stdenvNoCC.mkDerivation {
            name = "texmf";
            dontConfigure = true;
            src = ./.;
            installPhase = ''
                         mkdir $out
                         cp -r $src/tex/ $out
                         cp -r $src/bibtex/ $out
                           '';
          };
        }
    );
}

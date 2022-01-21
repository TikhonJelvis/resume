{
  description = "My resume as a Nix Flake. How's this for resume-driven development?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-medium
            footmisc
            titling
            xpatch
            noto;
        };
      in rec {
        packages = {
          resume = pkgs.stdenvNoCC.mkDerivation {
            name = "resume";
            src = ./resume;
            buildInputs = with pkgs; [ coreutils tex pandoc ];
          };
        };

        defaultPackage = packages.resume;
      }
    );
}

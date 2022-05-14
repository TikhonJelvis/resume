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
            enumitem
            environ
            footmisc
            fontawesome
            newunicodechar
            tcolorbox
            titlesec
            titling
            xpatch
            noto;
        };
      in rec {
        packages = {
          resume = pkgs.stdenvNoCC.mkDerivation {
            name = "resume";
            src = ./.;
            buildInputs = with pkgs; [ coreutils tex pandoc texlab ];

            FONTCONFIG_FILE = pkgs.makeFontsConf {
              fontDirectories = with packages.fonts; with pkgs; [
                aller
                bakoma_ttf
                lmodern
                fira
                junction
                dejavu_fonts
                eb-garamond
                gyre-fonts
                twitter-color-emoji
              ];
            };

            # Trailing comma (:) is important! Without it, LaTeX won't
            # find standard classes like article.cls.
            TEXINPUTS = "./latex:";
          };

          fonts = {
            junction = pkgs.fetchzip rec {
              name = "junction-1.0";
              url = "https://github.com/theleagueof/junction/archive/master.zip";
              sha256 = "110jsijn3i26d2487c9680w2z8g3bxflxjlsc4yhyc3wbmb7v1b8";

              postFetch = ''
                mkdir -p $out/share/fonts
                unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
                unzip -j $downloadedFile \*.otf -d $out/share/fonts/opentype
              '';
            };

            aller = pkgs.fetchzip rec {
              name = "aller-1.0";
              url = "https://www.1001fonts.com/download/aller.zip";
              sha256 = "0fr1s7983iywlvkqw98iyh149ic2paah0yaww9qiapc43vf9zlmf";

              postFetch = ''
                mkdir -p $out/share/fonts
                unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
              '';
            };
          };
        };

        defaultPackage = packages.resume;
      }
    );
}

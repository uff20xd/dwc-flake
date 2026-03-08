{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neuswc = "github:uff20xd/neuswc-flake";
  };

  outputs = { self, nixpkgs, neuswc }: 
    let 
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = pkgsRaw: evaluation: (nixpkgs.lib.genAttrs supportedSystems) (system:  evaluation system pkgsRaw.${system});
    in {
      packages = forAllSystems nixpkgs.legacyPackages (system: pkgs: rec {
          default = dwc;
          dwc = pkgs.stdenv.mkDerivation rec {
            name = "dwc";
            src = fetchGit {
              url = "https://git.sr.ht/~corg/DWC";
              hash = "";
            };
            buildInputs = with pkgs; [
              bmake
              gcc
              pkg-config
              wayland-scanner 
              wayland
              neuswc.default
            ];
          };
          });
      devShells = forAllSystems nixpkgs.legacyPackages (system: pkgs: rec {
        default = pkgs.mkShellNoCC rec {
          nativeBuildInputs = [ pkgs.pkg-config ];
          buildInputs = with pkgs; [
            gcc
          ];
        };
      });
    };
}

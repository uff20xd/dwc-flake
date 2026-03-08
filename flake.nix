{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neuswc.url = "github:uff20xd/neuswc-flake";
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
              gcc
              bmake
              pkg-config
              udev 
              xcb-proto
              libdrm
              wayland-protocols
              wayland
              fontconfig
              pixman
              wayland-scanner
              neuwld
              neuswc
              libxkbcommon
              libdrm
            ];
          };
          neuswc = pkgs.stdenv.mkDerivation rec {
            name = "neuswc";
            src = pkgs.fetchgit {
              url = "https://git.sr.ht/~shrub900/neuswc";
              hash = "sha256-2y7nKZKKWQaxJSuz5ia4VIcR4ibsAt/M6oqDy5jRpg4=";
            };
            buildInputs = with pkgs; [
              gcc
              bmake
              pkg-config
              udev 
              xcb-proto
              libdrm
              wayland-protocols
              wayland
              fontconfig
              pixman
              wayland-scanner
              neuwld
              libxkbcommon
              libdrm
            ];
            installPhase = ''
            runHook preInstall
            bmake install PREFIX=$out
            runHook postInstall
            '';
          };
          neuwld = pkgs.stdenv.mkDerivation rec {
            name = "neuwld";
            src = pkgs.fetchgit {
              url = "https://git.sr.ht/~shrub900/neuwld";
              hash = "sha256-0+rgWrefh19bBEmcqw0Lal1PHkendtCkQ2EIg+LHb74=";
            };
            buildInputs = with pkgs; [
              gcc
              bmake
              pkg-config
              udev 
              xcb-proto
              libdrm
              wayland-protocols
              wayland
              fontconfig
              pixman
              wayland-scanner
            ];
            installPhase = ''
            runHook preInstall
            bmake install PREFIX=$out
            runHook postInstall
            '';
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

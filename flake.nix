{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let 
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = pkgsRaw: evaluation: (nixpkgs.lib.genAttrs supportedSystems) (system:  evaluation system pkgsRaw.${system});
    in {
      packages = forAllSystems nixpkgs.legacyPackages (system: pkgs: rec {
          default = pkgs.hello;
          });
      devShells = forAllSystems nixpkgs.legacyPackages (system: pkgs: rec {
        default = pkgs.mkShellNoCC rec {
          nativeBuildInputs = [ pkgs.pkg-config ];
          buildInputs = with pkgs; [
            gcc
          ];
        };
      });
    }
}

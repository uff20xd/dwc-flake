{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs = { self, nixpkgs }: 
    let 
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = pkgsRaw: evaluation: (nixpkgs.lib.genAttrs supportedSystems) (system:  evaluation system pkgsRaw.${system});
      config_file = ./config.h;
    in {
      packages = forAllSystems nixpkgs.legacyPackages (system: pkgs: rec {
          default = dwc;
          fixed-libdrm = (pkgs.libdrm.dev.overrideAttrs {
                postInstall = ''
                  sed -i -e 's/<drm.h>/<libdrm\/drm.h>/' $dev/include/xf86drmMode.h
                  sed -i -e 's/<drm_mode.h>/<libdrm\/drm_mode.h>/' $dev/include/xf86drmMode.h
                  sed -i -e 's/<drm.h>/<libdrm\/drm.h>/' $dev/include/xf86drm.h
                '';
              });
          dwc = pkgs.stdenv.mkDerivation rec {
            name = "dwc";
            src = pkgs.fetchgit {
              url = "https://git.sr.ht/~corg/DWC";
              hash = "sha256-MKHCFqey/7RzscUl4A6CDlmjmcm5D42nOgie+0KOHc8=";
            };
            config = config_file;
            preBuild = ''
              tempsrc="$( mktemp -d )"
              mkdir -p $tempsrc
              cp -r $src/. $tempsrc
              cd $tempsrc
              cp $config $tempsrc/config.h
            '';
            buildPhase = ''
              runHook preBuild
              cd $tempsrc
              bmake
              runHook postBuild
            '';
            buildInputs = with pkgs; [
              gcc
              bmake
              pkg-config
              udev 
              xcb-proto
              wayland-protocols
              wayland
              fontconfig
              pixman
              wayland-scanner
              neuwld
              neuswc
              libxkbcommon
              fixed-libdrm
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
              wayland-protocols
              wayland
              fontconfig
              pixman
              wayland-scanner
              neuwld
              libxkbcommon
              fixed-libdrm
              libinput
              xcb-imdkit
              xcb-proto
              xcbutilxrm
              libxcb
              libxcb-wm
            ];
            preBuild = ''
              tempsrc="$( mktemp -d )"
              cp -r $src/. $tempsrc
              chmod 755 $tempsrc/libswc
              cd $tempsrc
              sed -Ei -e 's/<drm_fourcc.h>/<libdrm\/drm_fourcc.h>/' $tempsrc/libswc/dmabuf.c
              sed -Ei -e 's/<drm.h>/<libdrm\/drm.h>/' $tempsrc/libswc/drm.c
              sed -Ei -e 's/<drm.h>/<libdrm\/drm.h>/' $tempsrc/libswc/output.c
            '';
            buildPhase = ''
              runHook preBuild
              cd $tempsrc
              chmod 755 protocol
              chmod 755 cursor
              chmod 755 launch
              chmod 755 extra
              bmake
              runHook postBuild
            '';
            installPhase = ''
            runHook preInstall
            cd $tempsrc
            sed -i -e "s/-m 4755//" $tempsrc/Makefile
            bmake install PREFIX=$out
            chmod 755 $out/bin/swc-launch
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
              wayland-protocols
              wayland
              fontconfig
              pixman
              wayland-scanner
              fixed-libdrm
            ];
            installPhase = ''
            runHook preInstall
            bmake install PREFIX=$out
            runHook postInstall
            '';
          };
          });
   };
}

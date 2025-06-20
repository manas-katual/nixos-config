{pkgs, ...}: let
  pname = "mechvibes";
  version = "2.3.6";

  src = pkgs.fetchurl {
    url = "https://github.com/hainguyents13/mechvibes/releases/download/v2.3.6/Mechvibes-2.3.6-hotfix.AppImage";
    hash = "sha256-ALc7ghAC7ER7j/6dK7Gsp4tccNqmaCdwVoGUwhjAmjs=";
  };
  appimageContents = pkgs.appimageTools.extract {inherit pname version src;};
in
    pkgs.appimageTools.wrapType2 {
      inherit pname version src;
      pkgs = pkgs;
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
        cp -r ${appimageContents}/usr/share/icons $out/share

        # unless linked, the binary is placed in $out/bin/cursor-someVersion
        # ln -s $out/bin/${pname}-${version} $out/bin/${pname}
      '';

      extraBwrapArgs = [
        "--bind-try /etc/nixos/ /etc/nixos/"
      ];

      # vscode likes to kill the parent so that the
      # gui application isn't attached to the terminal session
      dieWithParent = false;

      extraPkgs = pkgs: with pkgs; [
        unzip
        autoPatchelfHook
        asar
        xorg.libxshmfence
        # override doesn't preserve splicing https://github.com/NixOS/nixpkgs/issues/132651
        (buildPackages.wrapGAppsHook.override {inherit (buildPackages) makeWrapper;})
      ];
    }

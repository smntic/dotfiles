{
  lib,
  appimageTools,
  fetchurl,
  pkgs,
}: let
  version = "0.52.2";
  pname = "sabaki";

  src = fetchurl {
    url = "https://github.com/SabakiHQ/Sabaki/releases/download/v${version}/sabaki-v${version}-linux-x64.AppImage";
    hash = "sha256-wuCj5HvNZc2KOdc5O49upNToFDKiMMWexykctHi51EY=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    libxshmfence
  ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/*.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/*.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "An elegant Go board and SGF editor";
    homepage = "https://github.com/SabakiHQ/Sabaki";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}

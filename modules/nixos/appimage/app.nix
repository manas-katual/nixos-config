{ appimageTools, fetchurl }:
let
  pname = "nuclear";
  version = "0.6.30";

  src = fetchurl {
    url = "https://github.com/nukeop/nuclear/releases/download/v${version}/${pname}-v${version}.AppImage";
    hash = "0000000000000000000000000000000000000000000000000000";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}

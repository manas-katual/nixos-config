{ lib, stdenv, fetchFromGitHub, libevdev, nlohmann_json, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "wayvibes";
  version = "git";  # Change this if there's a proper release

  src = fetchFromGitHub {
    owner = "sahaj-b";
    repo = "wayvibes";
    rev = "main";  # Use a specific commit or tag if needed
    sha256 = "sha256-OYeAMF3J1FsY75b9kYQmIMy9bPyNCgXT+RoSobliU+I=";  # Run `nix-prefetch-url --unpack <URL>` to get this
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ libevdev nlohmann_json ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp wayvibes $out/bin/
  '';

  meta = with lib; {
    description = "A Wayland-native CLI that plays mechanical keyboard sounds on keypresses.";
    homepage = "https://github.com/sahaj-b/wayvibes";
    license = licenses.mit;
    maintainers = with maintainers; [ manas-katual ];
    platforms = platforms.linux;
  };
}

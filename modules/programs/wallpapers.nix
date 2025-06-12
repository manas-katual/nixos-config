{
  pkgs,
  userSettings,
  ...
}: let
  wallpaperRepo = pkgs.fetchgit {
    # owner = "JaKooLit";
    # repo = "Wallpaper-Bank";
    url = "https://github.com/JaKooLit/Wallpaper-Bank";
    rev = "b15f6c32a219257f18b9faf4664312101f58f435";
    sha256 = "sha256-rjNShu858WjbEQbIM7d8uVeUPZ3402H41dkYw6WMRHI=";
  };
in {
  home-manager.users.${userSettings.username} = {
    home.file = {
      "Pictures/Wallpapers-test" = {
        source = "${wallpaperRepo}";
        recursive = true;
      };
    };
  };
}

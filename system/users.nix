{
  userSettings,
  pkgs,
  ...
}: {
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "Manas Katual";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "libvirtd" "input"];
    packages = with pkgs; [];
  };
}

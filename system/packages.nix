{
  pkgs,
  userSettings,
  ...
}: let
  terminal = pkgs.${userSettings.terminal};
in {
  environment = {
    systemPackages = with pkgs; [
      # terminal tools
      neovim # text editor
      wget # downloader
      terminal
      htop # cpu usage
      fastfetch # system info
      tldr # helper
      usbutils # manage usb
      pciutils # manage pci
      xdg-utils # environment integration
      # coreutils # GNU utils
      procps # GNU utils with addition
      gvfs # samba
      nix-tree # browse nix store
      pulseaudio # audio controller
      syncthing

      # gui apps
      # google-chrome # browser
      firefox # browser
      image-roll # image viewer
      mpv # video player
      qbittorrent # torrent client
      appimage-run # for appimages
      anydesk # remote access
      lan-mouse # kbd & mouse share
      localsend # wireless file transfer
      bottles # to run windows apps
      vscode-fhs # vscode for noobs
      mission-center # task manager for linux
      komikku # manga reader
      zathura # pdf reader
      hplip # hp printing drivers
      onlyoffice-desktopeditors # office suite
      neovide # neovim gui
      hardinfo2 # shows hardware info
      # ciscoPacketTracer8 # networking emulation
      vesktop # discord client
      obsidian

      # games and emulation
      mcpelauncher-ui-qt # minecraft bedrock edition
      ppsspp-sdl-wayland # psp emulator
      dolphin-emu-primehack # gamecube and wii emulator
    ];
  };
}

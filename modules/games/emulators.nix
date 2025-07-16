{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # games and emulation
      mcpelauncher-ui-qt # minecraft bedrock edition
      ppsspp-sdl-wayland # psp emulator
      dolphin-emu-primehack # gamecube and wii emulator
    ];
  };
}

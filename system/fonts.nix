{pkgs, ...}: {
  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome # Icons
    corefonts # MS
    noto-fonts # Google + Unicode
    noto-fonts-cjk-sans
    noto-fonts-emoji
    powerline-fonts
    powerline-symbols
    twemoji-color-font
    intel-one-mono
    fira-code
    fira-mono
    fira-sans
    nerd-fonts.dejavu-sans-mono
    dejavu_fonts
  ];
}

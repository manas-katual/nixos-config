{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.95;

      font = {
        size = 13.0;
        draw_bold_text_with_bright_colors = true;
        normal = {
          family = "Intel One Mono";
          style = "Normal";
        };
      };

      colors.primary.background = "#2e3440";
    };
  };
}

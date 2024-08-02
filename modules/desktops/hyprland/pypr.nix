{

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads"
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "75% 60%"

    [scratchpads.volume]
    command = "pavucontrol"
    margin = 50
    unfocus = "hide"
    animation = "fromTop"

    [scratchpads.bluetooth]
    animation = "fromTop"
    command = "blueberry"
    class = "blueberry.py"
    size = "75% 60%"
  '';

}

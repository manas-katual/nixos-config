{pkgs}:
pkgs.writeShellScriptBin "waybar-kill" ''

  if pgrep waybar > /dev/null; then
    pkill waybar
  else
    ${pkgs.waybar}/bin/waybar &
  fi
''

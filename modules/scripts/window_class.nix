{pkgs}:
pkgs.writeShellScriptBin "window_class" ''
  hyprctl activewindow -j 2>/dev/null | ${pkgs.jq}/bin/jq -r '.class // .initialClass // " 🙈 No Windows? "' || echo " 🙈 No Windows? "
''

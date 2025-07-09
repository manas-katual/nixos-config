{pkgs, ...}:
pkgs.writeShellScriptBin "sway_window" ''
  ${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '
  def walk:
    .nodes[], (.floating_nodes[]?) | walk? // .;
  walk
  | select(.focused == true)
  | .app_id // .window_properties.class // "🙈 No Windows?"
  ' || echo "🙈 No Windows?"
''

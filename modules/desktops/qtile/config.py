from typing import List  # noqa: F401
import os
import subprocess
from os import path

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, Key, Match, Screen
from libqtile.lazy import lazy
from settings.path import qtile_path
from extra import multiColorTag
import colors

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from qtile_extras.widget import decorations
from qtile_extras.widget.decorations import RectDecoration

mod = "mod4"
terminal = "kitty"
mymenu = "rofi -show drun"
browser = "flatpak run com.vivaldi.Vivaldi"
files = "krusader"
discord = "webcord"
todoist = "flatpak run com.todoist.Todoist"
screenie = "flameshot gui"

colors, backgroundColor, foregroundColor, workspaceColor, chordColor = colors.gruvbox()

########## Powerline from extras ########

arrow_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_right",
            size=11,
        )
    ]
}
arrow_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_left",
            size=11,
        )
    ]
}
rounded_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="rounded_right",
            size=11,
        )
    ]
}
rounded_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="rouded_left",
            size=11,
        )
    ]
}
slash_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="forward_slash",
            size=11,
        )
    ]
}
slash_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="back_slash",
            size=11,
        )
    ]
}

right_hand1 = {
    "decorations": [
        RectDecoration(colour=colors[11], radius=[0, 4, 4, 0], filled=True, padding_y=4, padding_x=0)
    ],
    "padding": 10,
}


left_hand1 = {
    "decorations": [
        RectDecoration(colour=colors[6], radius=[4, 0, 0, 4], filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}

left_hand2 = {
    "decorations": [
        RectDecoration(colour=colors[4], radius=[4, 0, 0, 4], filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}

left_hand3 = {
    "decorations": [
        RectDecoration(colour=colors[5], radius=[4, 0, 0, 4], filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}


left_hand4 = {
    "decorations": [
        RectDecoration(colour=colors[7], radius=[4, 0, 0, 4], filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}


left_hand5 = {
    "decorations": [
        RectDecoration(colour=colors[8], radius=[4, 0, 0, 4], filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}

left_hand6 = {
    "decorations": [
        RectDecoration(colour=colors[3], radius=[4, 0, 0, 4], filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}



keys = [

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "x", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "d", lazy.spawn(mymenu)),
    Key([mod], "w", lazy.spawn(browser)),
    Key([mod, "shift"], "Return", lazy.spawn(files)),
    Key([mod, "mod1"], "s", lazy.spawn(screenie)),
    Key(["mod1"], "s", lazy.spawn(todoist)),
    Key(["mod1"], "n", lazy.spawn(discord)),


    # Movement Keys
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

# Switch focus to specific monitor (out of three)
    Key([mod], "i", lazy.to_screen(0)),
    Key([mod], "o", lazy.to_screen(1)),

# Switch focus of monitors
    Key([mod], "period", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),


]

# Create labels for groups and assign them a default layout.
groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal", "F1", "F2", "F3", "F4", "F5"]

group_labels = ["󰖟", "", "", "", "", "", "", "", "ﭮ", "", "", "﨣", "F1", "F2", "F3", "F4", "F5"]
#group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]

group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

# Add group names, labels, and default layouts to the groups object.
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

# Add group specific keybindings
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Mod + number to move to that group."),
        Key(["mod1"], "Tab", lazy.screen.next_group(), desc="Move to next group."),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group(), desc="Move to previous group."),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), desc="Move focused window to new group."),
    ])


# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

# Define scratchpads
groups.append(ScratchPad("scratchpad", [
    DropDown("term", "kitty --class=scratch", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1),
    DropDown("term2", "kitty --class=scratch", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1),
    DropDown("ranger", "kitty --class=ranger -e ranger", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
    DropDown("volume", "kitty --class=volume -e pulsemixer", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
    DropDown("mus", "kitty --class=mus -e flatpak run io.github.hrkfdn.ncspot", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
    DropDown("news", "kitty --class=news -e newsboat", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),

]))

# Scratchpad keybindings
keys.extend([
    Key([mod], "n", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod], "c", lazy.group['scratchpad'].dropdown_toggle('ranger')),
    Key([mod], "v", lazy.group['scratchpad'].dropdown_toggle('volume')),
    Key([mod], "m", lazy.group['scratchpad'].dropdown_toggle('mus')),
    Key([mod], "b", lazy.group['scratchpad'].dropdown_toggle('news')),
    Key([mod, "shift"], "n", lazy.group['scratchpad'].dropdown_toggle('term2')),
])


def open_rofi():
    qtile.cmd_spawn("rofi -show drun -show-icons")


# Define layouts and layout themes
layout_theme = {
        "margin":20,
        "border_width": 4,
        "border_focus": colors[6],
        "border_normal": colors[2]
    }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.MonadThreeCol(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Spiral(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]

logo = widget.TextBox(text="  ", font="JetBrainsMono Nerd Font", mouse_callbacks={"Button1": open_rofi}, fontsize=20, background=colors[4], margin=4, padding=3)
sep = widget.Sep(linewidth = 1, padding = 15, foreground = colors[0], background = colors[0])
spacer1 = widget.Spacer(length=1, background=colors[4])
spacer2 = widget.Spacer(length=1, background=colors[6], **arrow_powerlineLeft)
spacer3 = widget.Spacer(background=colors[0])
spacer4 = widget.Spacer(length=4, background=colors[0])
groupbox =  widget.GroupBox(
                font="JetBrainsMono Nerd Font Mono",
                fontsize=23,
                padding_x=5,
                padding_y=5,
                rounded=False,
                center_aligned=True,
                disable_drag=True,
                borderwidth=3,
                highlight_method="line",
                hide_unused = True,
                active=colors[6],
                inactive=colors[1],
                highlight_color=colors[0],
                this_current_screen_border=colors[3],
                this_screen_border=colors[7],
                other_screen_border=colors[4],
                other_current_screen_border=colors[3],
                background=colors[0],
                foreground=colors[3],
            )
weather = widget.OpenWeather(
            app_key = "4cf3731a25d1d1f4e4a00207afd451a2",
            cityid = "4997193",
            format = '{icon} {main_temp}°',
            metric = False,
            font = "JetBrainsMono Nerd Font Mono",
            fontsize = 13,
            background = colors[0],
            foreground = colors[2],
        )
cpu = widget.CPU(font="JetBrainsMono Nerd Font", format="{freq_current}GHz {load_percent}%", foreground=colors[2], background=colors[0], **right_hand1)
cpuicon = widget.TextBox(text = "", fontsize = 20, font = "JetBrainsMono Nerd Font Mono", background = colors[0], foreground = colors[0], **left_hand1)

temp = widget.ThermalSensor(font="JetBrainsMono Nerd Font", update_interval=1, format="{temp:.0f}{unit}", tag_sensor="Tctl", foreground=colors[2], background=colors[0], **right_hand1)
tempicon = widget.TextBox(text = "󰔐", fontsize = 20, font = "JetBrainsMono Nerd Font Mono", background = colors[0], foreground = colors[0], **left_hand2)

mem = widget.Memory(font="JetBrainsMono Nerd Font", format=" {MemUsed:.0f}{mm}", background=colors[0], foreground=colors[2], **right_hand1)
memicon = widget.TextBox(text = "󰈀", fontsize = 20, font = "JetBrainsMono Nerd Font Mono", background = colors[0], foreground = colors[0], **left_hand3)

clockicon = widget.TextBox(text = "", fontsize = 20, font = "JetBrainsMono Nerd Font Mono", background = colors[0], foreground = colors[0], **left_hand4)
clock = widget.Clock(font="JetBrainsMono Nerd Font", format=" %a %d %b %I:%M:%S", foreground=colors[2], background=colors[0], **right_hand1)

volicon = widget.TextBox(text = "󰕾", fontsize = 20, font = "JetBrainsMono Nerd Font Mono", background = colors[0], foreground = colors[0], **left_hand5)
vol = widget.Volume(fmt="{}", font="JetBrainsMono Nerd Font", foreground=colors[2], background=colors[0], **right_hand1)
    
curlayout= widget.CurrentLayoutIcon(scale=0.5, background = colors[0], **left_hand6)
layoutname = widget.CurrentLayout(font = "JetBrainsMono Nerd Font", foreground=colors[2], background=colors[0], **right_hand1)

tray = widget.Systray(background = colors[0])

screens = [
    Screen(
        top=bar.Bar([
            logo,
            spacer1,
            groupbox,
            spacer3,
            curlayout,
            layoutname,
            spacer4,
            cpuicon,
            cpu,
            spacer4,
            tempicon,
            temp,
            spacer4,
            memicon,
            mem,
            spacer4,
            clockicon,
            clock,
            spacer4,
            volicon,
            vol,
            spacer4,
            tray,
            spacer4,
            ],
            margin=6,
            size=30),
        ),
    Screen(
        top=bar.Bar([
            logo,
            spacer1,
            groupbox,
            spacer3,
            curlayout,
            layoutname,
            cpuicon,
            cpu,
            tempicon,
            temp,
            memicon,
            mem,
            clockicon,
            clock,
            volicon,
            vol,
            ],
            size=30,
            margin=6),
        ),

    Screen(
        top=bar.Bar([
            logo,
            spacer1,
            groupbox,
            spacer3,
            curlayout,
            layoutname,
            cpuicon,
            cpu,
            tempicon,
            temp,
            memicon,
            mem,
            clockicon,
            clock,
            volicon,
            vol,
            ],
            size=30,
            margin=6),
        ),
    Screen(
    top=bar.Bar([
            logo,
            spacer1,
            groupbox,
            spacer3,
            curlayout,
            layoutname,
            cpuicon,
            cpu,
            tempicon,
            temp,
            memicon,
            mem,
            clockicon,
            clock,
            volicon,
            vol,
            ],
            size=30,
            margin=6),
        )
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# @hook.subscribe.startup_once
# def autostart():
#     home = os.path.expanduser('~/.config/qtile/autostart.sh')
#     subprocess.Popen([home])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "qtile"


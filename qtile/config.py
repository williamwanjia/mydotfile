# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

#  from libqtile import bar, layout, widget
from libqtile import bar, layout
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

import os
import subprocess

from libqtile import hook


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])


mod = "mod1"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    #  Key([mod, "control"], "h", lazy.layout.grow_left(),
    Key([mod, "control"], "h", lazy.layout.decrease_ratio(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.increase_ratio(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    #  Key([mod], "r", lazy.spawncmd(),
    #      desc="Spawn a command using a prompt widget"),
    Key([mod], "x", lazy.spawn("rofi -show combi"),
        desc="Start rofi"),
    Key([mod], "c", lazy.spawn("rofi -show ssh"),
        desc="Start rofi for ssh"),
    Key([mod], "t", lazy.window.toggle_floating(), desc='Toggle floating'),
    KeyChord([mod], "r",
             [Key([], "g",
                  lazy.spawn("google-chrome"),
                  desc='Launch Chrome'
                  ), ]),
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(toggle=True),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        #  Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
        #      desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
           desc="move focused window to group {}".format(i.name)),
    ])

layouts = [
    #  layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
    #  layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    #  layout.MonadTall(),
    # layout.RatioTile(),
    layout.Tile(margin=5, add_after_last=True),
    #  layout.Floating(),
    layout.TreeTab(fontsize=15,
                   panel_width=120),
    layout.Matrix(margin=3),
    layout.MonadWide(),
    # layout.VerticalTile(),
    #  layout.Zoomy(),
]

# Copied from DT
colors = [["#282c34", "#282c34"],  # panel background
          ["#3d3f4b", "#434758"],  # background for current screen tab
          ["#ffffff", "#ffffff"],  # font color for group names
          ["#ff5555", "#ff5555"],  # border line color for current tab
          ["#74438f", "#74438f"],  # border line color for 'other tabs' and color for 'odd widgets'
          ["#4f76c7", "#4f76c7"],  # color for the 'even widgets'
          ["#e1acff", "#e1acff"],  # window name
          ["#ecbbfb", "#ecbbfb"]]  # backbround for inactive screens


bar_size = 23

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize = bar_size - 8,
    padding = 3,
    background=colors[0]
)
extension_defaults = widget_defaults.copy()

pre_bc = widget_defaults['background']
pre_fc = None

powerline = {
    "decorations": [
        PowerLineDecoration(path="rounded_right")
    ]
}


def left_arrow(fc, bc):
    wgt = widget.TextBox(text='',
                         font="FontAwesome",
                         background=bc,
                         foreground=fc,
                         padding=-1,
                         fontsize=bar_size+18)
    return wgt


icon_path = [os.path.expanduser("~/Data/myrepos/dotfiles/.config/qtile/icons")]

# some icon characters
wifi_icon = ""

screens = [
    Screen(
        wallpaper="~/Documents/myrepos/mydotfile/i3wm/background/eve/eve1.jpg",
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(custom_icon_paths=icon_path,
                                         scale=0.7),
                widget.GroupBox(urgent_alert_method='border',
                                urgent_border='FC0505',
                                highlight_method='block'),
                #  widget.Prompt(),
                widget.TaskList(highlight_method='block',
                                max_title_width=160, **powerline),
                #  widget.WindowName(),
                #  widget.Chord(
                #      chords_colors={
                #          'launch': ("#ff0000", "#ffffff"),
                #      },
                #      name_transform=lambda name: name.upper(),
                #  ),
                #  widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                #  widget.OpenWeather(app_key="7d6dcb7250548b169c47397cdf78030a",
                #                     cityid=2792482,
                #                     format='{location_city}: {main_temp} ({main_feels_like})°{units_temperature} {humidity}% {wind_speed} {weather_details}'),
                #  left_arrow(colors[5], colors[0]),
                widget.Wttr(location={'Leuven':'Leuven'},
                            format='%c%t(%f) %w %h',
                            background=colors[5], **powerline),
                #  left_arrow(colors[0], colors[5]),
                #  widget.TextBox(text=wifi_icon,
                #                 font="FontAwesome"),
                widget.WiFiIcon(interface='wlp0s20f3',
                                **powerline),
                #  widget.Wlan(interface='wlp0s20f3',
                #              format='{essid} {percent:2.0%}', **powerline),
                #  widget.BatteryIcon(**powerline),
                #  widget.Battery(**powerline),
                widget.UPowerWidget(**powerline),
                #  left_arrow(colors[5], colors[0]),
                widget.TextBox('Cpu', background=colors[5], padding=0, **powerline),
                widget.CPUGraph(background=colors[5],
                                border_width=0, samples=30,
                                graph_color="8E8B8A",
                                fill_color="8E8B8A", **powerline),
                widget.TextBox('Mem', background=colors[5], **powerline),
                widget.MemoryGraph(background=colors[5],
                                   border_width=0, samples=30,
                                   graph_color="8E8B8A",
                                   fill_color="8E8B8A", **powerline),
                #  left_arrow(colors[0], colors[5]),
                widget.CapsNumLockIndicator(**powerline),
                #  left_arrow(colors[5], colors[0]),
                widget.TextBox(text='',
                               font="FontAwesome",
                               background=colors[5], **powerline),
                widget.Volume(background=colors[5], **powerline),
                #  widget.ALSAWidget(mode="both", background=colors[5], **powerline),
                widget.Systray(background=colors[5],
                               icon_size=bar_size - 10, **powerline),
                #  left_arrow(colors[0], colors[5]),
                widget.Clock(format='%Y-%m-%d %a %H:%M', **powerline),
                #  widget.QuickExit(),
            ],
            bar_size,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='guake'),  #
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

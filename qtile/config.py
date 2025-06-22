from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import subprocess
import os

mod = "mod4"
terminal = guess_terminal()


def get_volume():
    try:
        output = subprocess.check_output(["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"], text=True)
        parts = output.split()
        volume = float(parts[1])
        muted = "MUTED" in output.upper()

        if muted or volume == 0.0:
            return "  0%"
        elif volume < 0.3:
            return f"  {int(volume * 100)}%"
        elif volume < 0.7:
            return f"  {int(volume * 100)}%"
        else:
            return f"  {int(volume * 100)}%"
    except Exception:
        return "??%"


def separator_left(fg, bg):
    return widget.TextBox(text='', fontsize=28, padding=0, foreground=fg, background=bg)


def separator_right(fg, bg):
    return widget.TextBox(text='', fontsize=28, padding=0, foreground=fg, background=bg)


widget_defaults = dict(
    font="Lilex Nerd Font",
    fontsize=18,
    padding=6,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar([
            separator_left("#3c3836", "#1d2021"),
            widget.GroupBox(
                background="#3c3836",
                highlight_method="line",
                inactive="#d5c4a1",
                this_current_screen_border="#fe8019",
            ),

            separator_left("#fadb2f", "#3c3836"),
            widget.Prompt(
                prompt=" Spawn: ",
                background="#fadb2f",
                foreground="#282828",
                font="Lilex Nerd Font",
                padding=6,
            ),

            separator_left("#665c54", "#fadb2f"),
            widget.WindowName(background="#665c54", foreground="#fbf1c7", max_chars=40),

            separator_left("#a89984", "#665c54"),
            widget.Backlight(
                backlight_name="intel_backlight",  # change if different
                format="  {percent:2.0%} ",
                background="#a89984",
                foreground="#1d2021",
                step=5
            ),

            separator_left("#bdae93", "#a89984"),
            widget.GenPollText(
                func=get_volume,
                update_interval=1,
                fmt=" {} ",
                background="#bdae93",
                foreground="#1d2021",
            ),

            separator_left("#d5c4a1", "#bdae93"),
            widget.Battery(
                background="#d5c4a1",
                foreground="#1d2021",
                format=" {char} {percent:2.0%} ",
                charge_char="",
                discharge_char="",
                empty_char="",
                full_char="",
            ),

            separator_left("#ebdbb2", "#d5c4a1"),
            widget.Clock(
                background="#ebdbb2",
                foreground="#1d2021",
                format="  %I:%M %p    %a, %d %b"
            ),

            separator_left("#fb4934", "#ebdbb2"),
            widget.QuickExit(
                background="#fb4934",
                foreground="#fbf1c7",
                default_text=" ⏻ ",
                countdown_format=" {} "
            ),

            separator_right("#fb4934", "#1d2021"),
        ],
        32,
        background="#1d2021"
        )
    )
]


layouts = [
    layout.Columns(border_focus_stack=["#fabd2f", "#3c3836"], border_width=3),
    layout.Max(),
]

keys = [
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
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle split/unsplit"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "e", lazy.spawn("thunar"), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn command using prompt widget"),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), desc="Volume Up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/.local/bin/cap-volume.sh"), desc="Volume Down"),
    Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), desc="Mute Audio"),

    Key([], "XF86AudioMicMute", lazy.spawn("pamixer --default-source -t"), desc="Toggle microphone mute"),

    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%"), desc="Increase brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-"), desc="Decrease brightness"),

    Key([mod, "control"], "l", lazy.spawn("i3lock"), desc="Lock screen"),

    Key([mod], "d", lazy.spawn("rofi -show drun -theme ~/.config/rofi/themes/gruvbox-dark.rasi"), desc="Rofi launcher"),
]

for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = [Group(i) for i in "12345"]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )

os.environ["XCURSOR_THEME"] = "Future-Cursors"
os.environ["XCURSOR_SIZE"] = "24"

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(float_rules=[*layout.Floating.default_float_rules])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wl_xcursor_theme = "Future Cursors"
wl_xcursor_size = 24
wmname = "LG3D"

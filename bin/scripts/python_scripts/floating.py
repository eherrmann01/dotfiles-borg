#!/usr/bin/env python3
import i3ipc
import subprocess

DEFAULT_WIDTH = 800
DEFAULT_HEIGHT = 600

i3 = i3ipc.Connection()

def resize_if_floating(win):
    if win.floating in ('user_on', 'auto_on'):
        # Resize via xdotool using the window ID
        subprocess.run([
            'xdotool',
            'windowsize',
            str(win.window),
            str(DEFAULT_WIDTH),
            str(DEFAULT_HEIGHT)
        ])

def on_new_window(i3, e):
    resize_if_floating(e.container)

def on_floating_toggle(i3, e):
    resize_if_floating(e.container)

i3.on('window::new', on_new_window)
i3.on('window::floating', on_floating_toggle)

i3.main()


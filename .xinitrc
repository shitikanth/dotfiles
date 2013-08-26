#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

VBoxClient --clipboard &

# exec gnome-session
# exec startkde
# exec dwm
# exec startxfce4
exec awesome
# exec openbox-session
# ...or the Window Manager of your choice

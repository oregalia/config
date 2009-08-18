# Set BG with feh (--bg-tile, --bg-seamless, --bg-scale, --bg-center)
feh --bg-seamless ~/backgrounds/orgtree.png &

# Set cursor (LHP)
xsetroot -cursor_name left_ptr &

##### Startup Apps #####

# Term Apps
urxvt -e irssi &
urxvt -e htop &
urxvt -e ncmpcpp &
urxvt -title oregalia &


# GUI Apps
pidgin &
firefox &

# Daemons
xcompmgr -c &
mpdscribble &
#tleds -d 100 eth0 &

# Change to dvorak & map Caps_Lock to mod4
setxkbmap dvorak &
exec xmodmap -e "remove Lock = Caps_Lock" &
exec xmodmap -e "clear mod4" &
exec xmodmap -e "add Mod4 = Caps_Lock" &

# Start WM (xmonad)
exec xmonad 

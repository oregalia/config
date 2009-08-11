#Set the background using Feh
feh --bg-tile ~/backgrounds/AL.jpg &

# Set up xcompmgr
xcompmgr -c &
# Set the cursor to the standard LHP
xsetroot -cursor_name left_ptr &
setxkbmap dvorak &

# Startup Apps
# Term Apps
urxvt -e irssi &
urxvt -e htop &
urxvt -e ncmpcpp &
urxvt -title curiousfocus &

pidgin &
firefox &

mpdscribble &
# Map Caps_Lock correctly
exec xmodmap -e "remove Lock = Caps_Lock" &
exec xmodmap -e "clear mod4" &
exec xmodmap -e "add Mod4 = Caps_Lock" &

#
# Start xmonad
exec xmonad 

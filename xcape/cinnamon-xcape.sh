#!/bin/bash
#
echo $XDG_CURRENT_DESKTOP
if [ $XDG_CURRENT_DESKTOP = "GNOME" ] ;  then
   echo "Booo!"
   exit
fi

notify-send "cinnamon xcape starting"
#################
# Kill X server #
#################
setxkbmap -option terminate:ctrl_alt_bksp

############################################
# Set both shift keys to trigger caps lock #
############################################
setxkbmap -option "caps:none"
setxkbmap -option "shift:both_capslock"

killall xcape

################
# Super Keys:  #
################
xmodmap -e "keycode 135 = Super_R"
#xmodmap -e "keycode 134 = Super_R"
#xcape -e 'Super_L=Alt_L|Tab'
xcape -e 'Super_L=Control_L|Alt_L|z'
xcape -e 'Super_R=F12' # <<Menu key

#################
# Control keys: #
#################
xcape -e 'Control_L=Control_L|Alt_L|T' # << terminal desktop (2)
#xcape -e 'Control_R=Control_L|k|Control_L|v' 
xcape -e 'Control_R=Alt_L|j' 

############
# Alt Keys #
############
xcape -e 'Alt_L=Alt_L|w' # << browser
#Reconfigure Alt_gr
xmodmap -e "keycode 108 = Alt_R" && xset -r 108
xcape -e 'Alt_R=Alt_L|a'   # << Ulauncher

##############
# Shift Keys #
##############
xcape -e 'Shift_L=BackSpace|Escape'
xcape -e 'Shift_R=Control_L|Alt_L|m'

#############
# Caps Lock #
#############
#Disable caps lock key
xmodmap -e 'clear Lock'
xcape -e '#66=Super_L|2'
#!/bin/sh

if ! [ -f "$HOME/.fehrc" ]; then	
echo -e 'FEH="feh --bg-scale"
WALLPAPER_DIR="/usr/share/backgrounds"
floating=0' > $HOME/.fehrc
fi
. $HOME/.fehrc

desktop_state=$(bspc wm -g | grep -o "L.")

if [ "$floating" -eq 0 ]; then 
	if [ "$desktop_state" = LT ]; then 
		bspc desktop -l next
		default-terminal ranger $WALLPAPER_DIR --choosefile=/tmp/.rfile && $FEH --bg-fill $(cat /tmp/.rfile)
		bspc desktop -l next
	else
		default-terminal ranger $WALLPAPER_DIR --choosefile=/tmp/.rfile && $FEH --bg-fill $(cat /tmp/.rfile)
	fi
else
	bspc rule -a floaterm state=floating center=true
	st -c floaterm ranger $WALLPAPER_DIR --choosefile=/tmp/.rfile && $FEH --bg-fill $(cat /tmp/.rfile)
fi
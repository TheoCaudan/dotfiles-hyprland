#!/bin/bash

LOCK="exec hyprlock"
LOGOUT="loginctl terminate-user $USER"
RESTART="systemctl reboot"
SHUTDOWN="systemctl poweroff"

cat << EOF | wofi --show dmenu --prompt "Disconnection" --allow-html --hide-scroll --width 400 --height 80 --location center --style ~/.config/wofi/logout/style.css
<img src="/home/$USER/.config/wofi/logout/lock.png"/> Lock
<img src="/home/$USER/.config/wofi/logout/logout.png"/> Logout
<img src="/home/$USER/.config/wofi/logout/reboot.png"/> Restart
<img src="/home/$USER/.config/wofi/logout/shutdown.png"/> Shutdown
EOF

ACTION=$(echo $?)

case $ACTION in
    0) eval $LOCK ;;
    1) eval $LOGOUT ;;
    2) eval $RESTART ;;
    3) eval $SHUTDOWN ;;
esac

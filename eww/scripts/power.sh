#!/usr/bin/env bash

function ask() {
  action=$(echo -e "yes\nno" | tofi --prompt-text "$1 " --placeholder-text "$2" --padding-left 35% --padding-top 35%)
  if [ "$action" == "yes" ]; then
    return 0
  else
    return 1
  fi
}

poweroff="⭘ power off"
suspend=" suspend"
reboot=" reboot"
hibernate="󰤄 hibernate"
# emergency="emergency"
softreboot="soft reboot"
# rescue="rescue"
hybrid_sleep="H-sleep"

options="$suspend\n$poweroff\n$reboot\n$hibernate\n$softreboot\n$hybrid_sleep"

action=$(echo -e $options | tofi --prompt-text "⏻ " --num-results 4 --padding-left 35%)

# echo $action
case "$action" in
  "$poweroff")
    # [[ $(ask "⭘" "power off?") ]] && systemctl power off
    ask "⭘" "power off?" && systemctl poweroff
    ;;
  "$suspend")
    systemctl suspend
    ;;
  "$reboot")
    ask "" "reboot?" && systemctl reboot
    ;;
  "$hibernate")
    ask "󰤄" "hibernate?" && systemctl hibernate
    ;;
  "$softreboot")
    systemctl soft-reboot
    ;;
  "$hybrid_sleep")
    systemctl hybrid-sleep
    ;;
  # "$emergency")
  #   systemctl emergency
  #   ;;
  # "$rescue")
  #   systemctl rescue
  #   ;;
esac

#!/usr/bin/env bash

notify-send "Getting list of available Wi-Fi networks..."

wifi_list=$(
    nmcli --fields "SECURITY,SSID" device wifi list |
        sed 1d |
        sed 's/  */ /g' |
        sed -E 's/WPA*.?\S/ /g' |
        sed 's/^--/ /g' |
        sed 's/  //g' |
        sed '/--/d'
)

connected=$(nmcli -fields WIFI g)

if [[ "$connected" =~ enabled ]]; then
    toggle="󰖪  Disable Wi-Fi"
else
    toggle="󰖩  Enable Wi-Fi"
fi

chosen_network=$(
    printf "%s\n%s\n" "$toggle" "$wifi_list" |
        uniq -u |
        rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID:"
)

read -r chosen_id <<< "${chosen_network:3}"

case "$chosen_network" in
    "")
        exit 0
        ;;
    "󰖩  Enable Wi-Fi")
        nmcli radio wifi on
        exit 0
        ;;
    "󰖪  Disable Wi-Fi")
        nmcli radio wifi off
        exit 0
        ;;
esac

success_message="You are now connected to \"$chosen_id\"."

saved_connections=$(nmcli -g NAME connection)

if grep -Fxq "$chosen_id" <<< "$saved_connections"; then
    nmcli connection up id "$chosen_id" |
        grep -q "successfully" &&
        notify-send "Connection Established" "$success_message"
else
    if [[ "$chosen_network" =~  ]]; then
        wifi_password=$(rofi -dmenu -p "Password:")
    fi

    nmcli device wifi connect "$chosen_id" password "$wifi_password" |
        grep -q "successfully" &&
        notify-send "Connection Established" "$success_message"
fi

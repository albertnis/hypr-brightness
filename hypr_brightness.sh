#!/usr/bin/env sh
set +e

usage="Usage: $0 [+] or [-]"

if [ "$#" -ne 1 ]; then
    echo "No direction parameter provided"
    echo "$usage"
    exit 1
fi

arg="$1"

if [ "$arg" == "help" ] || [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
    echo "$usage"
    exit 0
fi

if [ "$arg" != "+" ] && [ "$arg" != "-" ]; then
    echo "Direction parameter must be '+' or '-'"
    echo $usage 
    exit 1
fi

direction=$arg

monitor_data=$(hyprctl monitors -j)
focused_name=$(echo $monitor_data | jq -r '.[] | select(.focused == true) | .name')

if [ "$focused_name" == "eDP-1" ]; then
    if [ "$direction" == "-" ]; then
        brillo -u 150000 -U 8
    else
        brillo -u 150000 -A 8
    fi
else
    focused_id=$(echo $monitor_data | jq -r '.[] | select(.focused == true) | .id')
    ddcutil --sleep-multiplier=.2 --display=$focused_id setvcp 10 $direction 15
fi

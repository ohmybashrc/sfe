#!/bin/bash

# Save for terminal emulators
printf '\e[?1049h'

get_term_size() {
    # '\e7':           Save the current cursor position.
    # '\e[9999;9999H': Move the cursor to the bottom right corner.
    # '\e[6n':         Get the cursor position (window size).
    # '\e8':           Restore the cursor to its previous position.
    IFS='[;' read -sp $'\e7\e[9999;9999H\e[6n\e8' -d R -rs _ LINES COLUMNS
}
get_term_size

# Trap the window resize signal (handle window resize events).
# See: 'help trap' and 'trap -l'
trap 'get_term_size; draw' WINCH

# Prevent usage of Ctrl+C to terminate
trap '' INT

# Function to draw UI
draw() {
    printf "\e[0;$LINESr\e[2J\e[H\e[1m"
    export TITLE="SFE 0.1"
    export FILE="test"
    printf "\e[7m"
    printf "  $TITLE"
    export SPACENUMBER=$(expr $COLUMNS - ${#FILE})
    export SPACENUMBER=$(expr $SPACENUMBER - ${#TITLE})
    export SPACENUMBER=$(expr $SPACENUMBER - 4)
    printf '%*s' $SPACENUMBER
    printf "$FILE  "
    printf "\033[0m"
    printf "\n$SCREEN_TEXT"
}

# Constantly read and draw
while true; do
    draw
    read -sn 1 char
    SCREEN_TEXT+=$char
done

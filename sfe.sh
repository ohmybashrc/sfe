#!/bin/bash

# Clear console, save for terminal emulators
printf '\e[?1049h'
printf '\e[2J'

get_term_size() {
    # '\e7':           Save the current cursor position.
    # '\e[9999;9999H': Move the cursor to the bottom right corner.
    # '\e[6n':         Get the cursor position (window size).
    # '\e8':           Restore the cursor to its previous position.
    IFS='[;' read -sp $'\e7\e[9999;9999H\e[6n\e8' -d R -rs _ LINES COLUMNS
}
# Trap the window resize signal (handle window resize events).
# See: 'man trap' and 'trap -l'
trap 'get_term_size' WINCH

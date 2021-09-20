#! /usr/bin/env bash

function vol-get {
    echo -en "\nVolume: "
    osascript -e "output volume of (get volume settings)"
    echo -en "Muted: "
    osascript -e "output muted of (get volume settings)"
}

function vol-mute {
    echo -en "\nMuting!\n\n"
    osascript -e 'set volume output muted true'
}

function vol-set {
    local vol="${1}"
    if ! [ "${1}" -eq "${1}" ] 2> /dev/null; then vol="50"; fi
    osascript -e "set volume output volume ${vol} --100%"
    echo -e "\nvol = ${vol}"
}

function vol {
    vol-set "${@}"
}

function vol-chg {
    local vol_chg="${1}"
    if [ -z "${vol_chg}" ]; then
        vol_chg="+10"
    elif [ "${vol_chg}" -eq "${vol_chg}" ] 2> /dev/null; then
        if [[ vol_chg -gt 0 ]]; then vol_chg="+${vol_chg}"; fi
    fi
    local osa_cmd="set volume output volume (output volume of"
    osa_cmd="${osa_cmd} (get volume settings) ${vol_chg}) --100%"
    osascript -e "${osa_cmd}"
    echo -e "\nvol ${vol_chg}"
}

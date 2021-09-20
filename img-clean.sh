#! /usr/bin/env bash

function rand-rename {
    local oldnames=("${@}")
    local newname
    local baseascii
    for oldname in "${oldnames[@]}"; do
        if [ -f "${oldname}" ]; then
            baseascii="$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | \
                sha256sum | head -c15)"
            newname="$(tr '[:upper:]' '[:lower:]' <<< \
                "$(dirname "${oldname}")/${baseascii}.${oldname##*.}")"
            mv "${oldname}" "${newname}"
            echo -en "${oldname}\t\t==>\t\t${newname}\n"
        fi
    done
}

function img-exifkill {
    echo -en "\nPass 1 (exiftool) ...\n\n"
    exiftool -overwrite_original_in_place -all='' "${@}"
    echo -en "\nPass 2 (exiv2) ...\n\n"
    exiv2 rm "${@}"
    echo -en "\n"
}

function img-sanitize {
    echo -en "\n>>> Cleaning EXIF tags ...\n\n"
    img-exifkill "${@}"
    echo -en "\n>>> Renaming ...\n\n"
    rand-rename "${@}"
    echo -en "\nDone!\n\n"
}

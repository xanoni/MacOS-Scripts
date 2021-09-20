#! /usr/bin/env -S bash -ex

function update {
    ${SUDO} softwareupdate -i -a
    brew update && brew upgrade && brew cleanup
    npm install npm -g && npm update -g && ${SUDO} gem update --system
    ${SUDO} gem update && ${SUDO} gem cleanup
}

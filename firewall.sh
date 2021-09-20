#! /usr/bin/env -S bash -ex

## basics of app firewall
function fw {
    if [ -z "$1" ]; then
        /usr/libexec/ApplicationFirewall/socketfilterfw -h
    else
        ${SUDO} /usr/libexec/ApplicationFirewall/socketfilterfw "$@"
    fi
}

## list apps
alias fw-ls="fw --listapps | grep-hl '\(.*allow.*\)'"
alias fw-list="fw-ls"

## global state (r/w)
alias fw-status="fw --getglobalstate && fw --setstealthmode on"
alias fw-on="fw --setglobalstate on"
alias fw-off="fw --setglobalstate off"

## add/remove apps
alias fw-add="fw --add"
alias fw-rm="fw --remove"

## block/unblock apps
alias fw-block="fw --blockapp"
alias fw-allow="fw --unblockapp"

## global block
alias fw-blockall-on="fw --setblockall on"
alias fw-blockall-off="fw --setblockall off"

## misc
alias fw-stealth-on="fw --setstealthmode on"
alias fw-stealth-off="fw --setstealthmode off"

## packet filter / networking
alias dnsflush="\${SUDO} dscacheutil -flushcache && \
    \${SUDO} killall -HUP mDNSResponder"
alias pf-status="\${SUDO} pfctl -a '*' -sr | grep-hl block"
alias pf-load="\${SUDO} pfctl -vf \$HOME/.my-configs/pf.conf && \${SUDO} pfctl -ve"
alias pf-on="\${SUDO} pfctl -ve"
alias pf-off="\${SUDO} pfctl -vd"
alias pf-flush="\${SUDO} pfctl -vFr"
alias mac-randomize="\${SUDO} ifconfig en0 ether \
    \$(openssl rand -hex 6 | sed 's%\(..\)%\1:%g; s%.$%%')"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | \
      grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | \
      awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

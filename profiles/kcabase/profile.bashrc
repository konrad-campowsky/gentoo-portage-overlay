maxjobs="$(grep MemTotal /proc/meminfo | awk '{ print int($(NF-1) / 2500000); }')"
jobs=$(( "${maxjobs}" < "$(nproc)" ? "${maxjobs}" : "$(nproc)" ))

MAKEOPTS="-j${jobs}"

unset jobs maxjobs 

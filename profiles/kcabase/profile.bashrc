maxjobs="$(grep MemTotal /proc/meminfo | awk '{ print int($(NF-1) / 2000000); }')"
jobs=$(( "${maxjobs}" < "$(nproc)" ? "${maxjobs}" : "$(nproc)" ))
MAKEOPTS="-j${jobs}"

unset jobs maxjobs 

if [ -z "${MAKEOPTS}" ]; then 
	maxjobs="$(grep MemTotal /proc/meminfo | awk '{ print int($(NF-1) / 2000000); }')"
	jobs=$(( "${maxjobs}" < "$(nproc)" ? "${maxjobs}" : "$(nproc)" ))

	MAKEOPTS="-j${jobs}"

	unset jobs maxjobs 
fi

pre_pkg_preinst() {
	rm -fr "${ED}"/usr/share/man/{man2*,man3*,a*,b*,c*,da,e*,f*,g*,h*,i*,j*,k*,l*,mann,n*,o*,p*,q*,r*,s*,t*,u*,v*,w*,x*,y*,z*}
}


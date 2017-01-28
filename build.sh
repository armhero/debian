#!/bin/sh

set -e

usage() {
	printf >&2 '%s: [-a arch] [-r release] [-t tag] [-m mirror] [-t tag]\n' "$0"
	exit 1
}

tmp() {
	TMP=$(mktemp -d ${TMPDIR:-/tmp}/debian-docker-XXXXXXXXXX)
	ROOTFS=$(mktemp -d ${TMPDIR:-/tmp}/debian-docker-rootfs-XXXXXXXXXX)
	trap "rm -rf $TMP $ROOTFS" EXIT TERM INT
}

mkbase() {
		cd $TMP
		env
		fakechroot fakeroot debootstrap --verbose --arch $ARCH --variant fakechroot $REL $ROOTFS/ $MIRROR
}

conf() {
	echo "${MAINREPO}\n" > $ROOTFS/etc/apk/repositories
	echo "${ADDITIONALREPO}\n" >> $ROOTFS/etc/apk/repositories
}

pack() {
	local id
	id=$(sudo tar --numeric-owner -C $ROOTFS -c . | docker import - armhero/debian:$REL)

	docker tag $id armhero/debian:$TAG
	docker run --rm armhero/debian:$TAG sh -c "echo debian:${REL} with id=${id} and tag=${TAG} created!\n'"
}

while getopts ":a:r:m:t:h" opt; do
	case $opt in
		a)
		  REL=$OPTARG
		  ;;
		r)
			REL=$OPTARG
			;;
		m)
			MIRROR=$OPTARG
			;;
		t)
		  TAG=$OPTARG
			;;
		h)
			usage
			;;
		\?)
	    echo "Invalid option: -$OPTARG" >&2
			exit 1
	    ;;
	esac
done

REL=${REL:-jessie}
MIRROR=${MIRROR:-http://httpredir.debian.org/debian/}
ARCH=${ARCH:-armhf}
TAG=${TAG:-latest}

echo "Create baseimage..."
mkbase
#echo "Configure package lists..."
#conf
echo "Pack image..."
pack
echo "Finished!"
exit 0

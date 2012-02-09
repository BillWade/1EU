#!/bin/bash

zdir="`dirname $0`"
sdir=`cd $zdir && pwd`

CD_DIR=`cd $sdir && cd .. && pwd`

#grep "x86_64" "$CD_DIR/media.1/products" 1>/dev/null 2>&1
#[ "$?" -eq "0" ] && arch=x86_64 || arch=i386

arch=x86_64

pushd "$CD_DIR" 1>/dev/null 2>&1
mkisofs -V SLES10CD.001 -f -r -J -l -allow-leading-dots -publisher "SuSE Linux GmbH" -b "boot/$arch/loader/isolinux.bin" -c "boot/$arch/loader/boot.cat" -no-emul-boot -boot-load-size 4 -boot-info-table -graft-points -o ../SLES-10.3-1EU-DVD.$arch.iso .
popd 1>/dev/null 2>&1


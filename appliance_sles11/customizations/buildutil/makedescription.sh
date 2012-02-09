#!/bin/bash

zdir="`dirname $0`"
sdir=`cd $zdir && pwd`

CD_DIR=`cd $sdir && cd .. && pwd`

for dir in `ls $CD_DIR/suse/ | grep -v setup`;
do
   pushd "$CD_DIR/suse/$dir" 1>/dev/null 2>&1
   rm -f MD5SUMS && md5sum * > MD5SUMS
   popd 1>/dev/null 2>&1
done

pushd $CD_DIR/suse 1>/dev/null 2>&1
create_package_descr -x setup/descr/EXTRA_PROV -l english -l spanish -l french -l german -l czech -l hungarian -l italian -C
popd 1>/dev/null 2>&1
pushd $CD_DIR/suse/setup/descr 1>/dev/null 2>&1
rm -f MD5SUMS && md5sum * > MD5SUMS
popd 1>/dev/null 2>&1


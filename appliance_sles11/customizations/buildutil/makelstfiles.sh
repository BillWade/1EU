#!/bin/bash

zdir="`dirname $0`"
sdir=`cd $zdir && pwd`

CD_DIR=`cd $sdir && cd .. && pwd`

for dir in `ls $CD_DIR/suse/ | grep -v setup`;
do
   pushd "$CD_DIR/suse/$dir" 1>/dev/null 2>&1
   ls *.rpm | sed -e "s/^\(.*\)\(-.*\)-.*$/\1\2/g" -e "s/\(^.*\)\..*$/\1/" > "$sdir/$dir.lst"
   popd 1>/dev/null 2>&1
done



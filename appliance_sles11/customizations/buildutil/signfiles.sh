#!/bin/bash

zdir="`dirname $0`"
sdir=`cd $zdir && pwd`

CD_DIR=`cd $sdir && cd .. && pwd`

LOCAL_KEY=`gpg --list-secret-keys $GPGKEY|grep "^sec"|sed -e 's/.*\///;s/ .*//g;'|head -n 1`

#Remove keys in content
grep -v ^META $CD_DIR/content > $CD_DIR/content.bak
mv $CD_DIR/content.bak $CD_DIR/content
grep -v ^KEY $CD_DIR/content > $CD_DIR/content.bak
mv $CD_DIR/content.bak $CD_DIR/content

#Set the key
gpg --export -a $LOCAL_KEY > $CD_DIR/gpg-pubkey-${LOCAL_KEY}.asc

for dir in `ls $CD_DIR/suse/ | grep -v setup`;
do
   pushd "$CD_DIR/suse/$dir" 1>/dev/null 2>&1
   ls *.rpm | sed -e "s/^\(.*\)\(-.*\)-.*$/\1\2/g" -e "s/\(^.*\)\..*$/\1/" > "$sdir/$dir.lst"
   popd 1>/dev/null 2>&1
done

# Sign files in /suse/setup/descr/
for FILE in `ls $CD_DIR/suse/setup/descr/`
do
	echo "META SHA1 $(cd $CD_DIR/suse/setup/descr/ && sha1sum ${FILE})" >> $CD_DIR/content
done
#Sign *.asc files
for FILE in `ls -1 $CD_DIR/|grep ^gpg-pubkey`
do
	echo "KEY SHA1 $(cd $CD_DIR && sha1sum ${FILE})" >> $CD_DIR/content
done

if [ -e $CD_DIR/content.asc ] ; then
  rm $CD_DIR/content.asc
fi
gpg --detach-sign -u $LOCAL_KEY -a $CD_DIR/content
gpg --export -a -u $LOCAL_KEY > $CD_DIR/content.key

if [ -e $CD_DIR/media.1/products.asc ] ; then
  rm $CD_DIR/media.1/products.asc
fi
gpg --detach-sign -u $LOCAL_KEY -a $CD_DIR/media.1/products
gpg --export -a -u $LOCAL_KEY > $CD_DIR/media.1/products.key


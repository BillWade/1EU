#!/bin/bash

zdir="`dirname $0`"
sdir=`cd $zdir && pwd`
missingfiles=""
missingcount=0

CD_DIR=`cd $sdir && cd .. && pwd`

for rpmlistfile in $sdir/*.lst
do
   echo
   # Dont ask, I was sick of playing with seds horrible regex
   ssdir=$(echo $sdir/ | sed -e "s/\//\\\\\//g")
   dirname=$(echo $rpmlistfile | sed -e "s/^$ssdir\(.*\)\.lst$/\1/g")

   ## Copy rpms from lst file to tmp directory
   [ ! -z $dirname ] || break;
   [ -d "$CD_DIR/suse/$dirname" ] && mkdir "$CD_DIR/suse/$dirname/tmp"
   if [ -d "$CD_DIR/suse/$dirname/tmp" ]
   then
      echo "Separating $dirname rpm files needed for install..."
      for filename in `cat $rpmlistfile`
      do
         ln $CD_DIR/suse/$dirname/$filename*.rpm $CD_DIR/suse/$dirname/tmp/ 1>/dev/null 2>&1
      done
   fi

   ## Compare list to tmp directory and find missing rpms
   echo "Checking for missing $dirname rpm files..."
   filename=""
   for filename in `cat $rpmlistfile`
   do
      ls $CD_DIR/suse/$dirname/tmp/$filename*.rpm 1>/dev/null 2>&1
      if [ "$?" -ne "0" ]
      then
         missingfiles="$missingfiles
$filename ($dirname)"
         let "missingcount++"
      fi
   done
done

if [ "$missingcount" -gt "0" ]
then
   echo -n "The following RPMs are missing:
$missingfiles

Do you still want to continue? [y/n] "
   read yn
   case $yn in
      y | Y)
         abort="bypassmissing"
      ;;
      *)
         echo "Cleaning up..."
         abort="yes"
      ;;
   esac
else
   abort="nomissing"
fi

for rpmlistfile in $sdir/*.lst
do
   # Dont ask, I was sick of playing with seds horrible regex
   ssdir=$(echo $sdir/ | sed -e "s/\//\\\\\//g")
   dirname=$(echo $rpmlistfile | sed -e "s/^$ssdir\(.*\)\.lst$/\1/g")

   if [ "$abort" = "yes" ]
   then
      rm -fr "$CD_DIR/suse/$dirname/tmp/"
   else
      echo "Removing Excess $dirname rpm files..."
      find "$CD_DIR/suse/$dirname/" -maxdepth 1 -name "*.rpm" -exec rm -f {} \;
      mv $CD_DIR/suse/$dirname/tmp/* $CD_DIR/suse/$dirname/
      rmdir $CD_DIR/suse/$dirname/tmp/
      pushd "$CD_DIR/suse/$dirname" 1>/dev/null 2>&1
      rm -f MD5SUMS 1>/dev/null 2>&1
      md5sum * > MD5SUMS 1>/dev/null 2>&1
      popd 1>/dev/null 2>&1
   fi
done

if [ "$abort" = "bypassmissing" ]
then
   echo "Could not find the following packages: $missingfiles"
   echo "Please add them manually!"
   echo
elif [ "$abort" = "nomissing" ]
then
   echo "Operation Complete!"
   echo
else
   echo "Operation Aborted!"
   echo
fi


#!/bin/bash

# Globals
TOP=`pwd`
BUILDDIR=$TOP
ISODIR=/home/binaries/SLES
source /etc/profile.d/ant.sh

export version=5.6.3
echo version=$version
export version_p4=`cat ./changelist`
echo $version_p4

PRODUCT=Foglight

ISOFNAME="$PRODUCT"-"$version"-"$version_p4"-"x86_64.iso"
MD5FNAME="$PRODUCT"-"$version"-"$version_p4"-"x86_64.iso.md5"
BUILD_SERVER=http://$HUDSON_1EU_HEAD:8080

BINARIES_DIR=/home/binaries
RPM_PATCHES_DIR=$BINARIES_DIR/rpmpatches
THIRD_PARTY_DIR=$BINARIES_DIR/3rdparty
QUEST_RPMS_DIR=$TOP/customizations/rpms

APPLIANCEMON_ARTIFACTS_DIR=$BUILD_SERVER/job/appliancemon/lastSuccessfulBuild/artifact/artifacts/
ARCHIVER_ARTIFACTS_DIR=$BUILD_SERVER/job/archiver/lastSuccessfulBuild/artifact/artifacts/
OSCONFIG_ARTIFACTS_DIR=$BUILD_SERVER/job/osconfig/lastSuccessfulBuild/artifact/artifacts/
CONSOLE_ARTIFACTS_DIR=$BUILD_SERVER/job/console/lastSuccessfulBuild/artifact/artifacts/
DELLOPENMANAGE_ARTIFACTS_DIR=$BUILD_SERVER/job/dell-openmanage/lastSuccessfulBuild/artifact/artifacts/
RELAYER_ARTIFACTS_DIR=$BUILD_SERVER/job/relayer/lastSuccessfulBuild/artifact/artifacts/
SNIFFER_ARTIFACTS_DIR=$BUILD_SERVER/job/sniffer/lastSuccessfulBuild/artifact/artifacts/
MYSQL_ARTIFACTS_DIR=$BUILD_SERVER/job/mysql/lastSuccessfulBuild/artifact/artifacts/
LOCATIONDB_ARTIFACTS_DIR=$BUILD_SERVER/job/locationdb/lastSuccessfulBuild/artifact/artifacts/
FMS_ARTIFACTS_DIR=$BUILD_SERVER/job/foglightrpm/lastSuccessfulBuild/artifact/artifacts/
CART_ENDUSER_ARTIFACTS_DIR=$BUILD_SERVER/job/cartridges-enduser/lastSuccessfulBuild/artifact/artifacts/
CART_ENDUSERMODELS_ARTIFACTS_DIR=$BUILD_SERVER/job/cartridges-endusermodels/lastSuccessfulBuild/artifact/artifacts/
CONFIGURATIONMANAGEMENTEU_ARTIFACTS_DIR=$BUILD_SERVER/job/configurationmanagementeu/lastSuccessfulBuild/artifact/artifacts/

# Temporary dev upgrade RPM. Remove for release
UPGRADE_DEVEL_ARTIFACTS_DIR=$BUILD_SERVER/job/upgrade-devel/lastSuccessfulBuild/artifact/artifacts/
UPGRADE_DEVEL_ZIP_FILE=quest-1EU-devel-latest.rpm.tar.gz

APPLIANCEMON_ZIP_FILE=quest-1EU-appliancemon-dell-latest.rpm.tar.gz
ARCHIVER_ZIP_FILE=quest-1EU-archiver-dell-latest.rpm.tar.gz
OSCONFIG_ZIP_FILE=quest-1EU-osconfig-latest.rpm.tar.gz
CONSOLE_ZIP_FILE=quest-1EU-console-latest.rpm.tar.gz
DELLOPENMANAGE_ZIP_FILE=quest-1EU-dellopenmanage-latest.rpm.tar.gz
RELAYER_ZIP_FILE=quest-1EU-relayer-dell-latest.rpm.tar.gz
SNIFFER_ZIP_FILE=quest-1EU-sniffer-dell-latest.rpm.tar.gz
MYSQL_ZIP_FILE=quest-1EU-mysql-latest.rpm.tar.gz
LOCATIONDB_ZIP_FILE=quest-1EU-locationdb-latest.rpm.tar.gz
FMS_ZIP_FILE=quest-foglight-dell-latest.rpm.tar.gz
CART_ENDUSER_ZIP_FILE=quest-1EU-cartridges-enduser-latest.rpm.tar.gz
CART_ENDUSERMODELS_ZIP_FILE=quest-1EU-cartridges-endusermodels-latest.rpm.tar.gz
CART_ENDUSER_DEFAULTS_ALLINONE_ZIP_FILE=quest-1EU-cartridges-enduser-defaults-allinone.rpm.tar.gz
CART_ENDUSER_DEFAULTS_FOGLIGHTONLY_ZIP_FILE=quest-1EU-cartridges-enduser-defaults-foglightonly.rpm.tar.gz

SLES_PATTERN_FILE=base-11-38.13.9.x86_64.pat.gz

cd $TOP
#Get the latest upgrade-devel RPM file. Remove for release
if [ -e $TOP/$UPGRADE_DEVEL_ZIP_FILE ] ; then
  rm $TOP/$UPGRADE_DEVEL_ZIP_FILE
fi
curl -C - -O $UPGRADE_DEVEL_ARTIFACTS_DIR/$UPGRADE_DEVEL_ZIP_FILE

#Get the latest appliancemon RPM file
if [ -e $TOP/$APPLIANCEMON_ZIP_FILE ] ; then
  rm $TOP/$APPLIANCEMON_ZIP_FILE
fi
curl -C - -O $APPLIANCEMON_ARTIFACTS_DIR/$APPLIANCEMON_ZIP_FILE

#Get the latest archiver RPM file
if [ -e $TOP/$ARCHIVER_ZIP_FILE ] ; then
  rm $TOP/$ARCHIVER_ZIP_FILE
fi
curl -C - -O $ARCHIVER_ARTIFACTS_DIR/$ARCHIVER_ZIP_FILE

#Get the latest console RPM file
if [ -e $TOP/$CONSOLE_ZIP_FILE ] ; then
  rm $TOP/$CONSOLE_ZIP_FILE
fi
curl -C - -O $CONSOLE_ARTIFACTS_DIR/$CONSOLE_ZIP_FILE

#Get the latest dell OpenManage RPM file
if [ -e $TOP/$DELLOPENMANAGE_ZIP_FILE ] ; then
  rm $TOP/$DELLOPENMANAGE_ZIP_FILE
fi
curl -C - -O $DELLOPENMANAGE_ARTIFACTS_DIR/$DELLOPENMANAGE_ZIP_FILE

#Get the latest osconfig RPM file
if [ -e $TOP/$OSCONFIG_ZIP_FILE ] ; then
  rm $TOP/$OSCONFIG_ZIP_FILE
fi
curl -C - -O $OSCONFIG_ARTIFACTS_DIR/$OSCONFIG_ZIP_FILE

#Get the latest relayer RPM file
if [ -e $TOP/$RELAYER_ZIP_FILE ] ; then
  rm $TOP/$RELAYER_ZIP_FILE
fi
curl -C - -O $RELAYER_ARTIFACTS_DIR/$RELAYER_ZIP_FILE

#Get the latest mysql RPM file
if [ -e $TOP/$MYSQL_ZIP_FILE ] ; then
  rm $TOP/$MYSQL_ZIP_FILE
fi
curl -C - -O $MYSQL_ARTIFACTS_DIR/$MYSQL_ZIP_FILE

#Get the latest sniffer RPM file
if [ -e $TOP/$SNIFFER_ZIP_FILE ] ; then
  rm $TOP/$SNIFFER_ZIP_FILE
fi
curl -C - -O $SNIFFER_ARTIFACTS_DIR/$SNIFFER_ZIP_FILE

#Get the latest locationdb RPM file
if [ -e $TOP/$LOCATIONDB_ZIP_FILE ] ; then
  rm $TOP/$LOCATIONDB_ZIP_FILE
fi
curl -C - -O $LOCATIONDB_ARTIFACTS_DIR/$LOCATIONDB_ZIP_FILE

#Get the latest FMS RPM file
if [ -e $TOP/$FMS_ZIP_FILE ] ; then
  rm $TOP/$FMS_ZIP_FILE
fi
curl -C - -O $FMS_ARTIFACTS_DIR/$FMS_ZIP_FILE

#Get the latest cartridges-enduser RPM file
if [ -e $TOP/$CART_ENDUSER_ZIP_FILE ] ; then
  rm $TOP/$CART_ENDUSER_ZIP_FILE
fi
curl -C - -O $CART_ENDUSER_ARTIFACTS_DIR/$CART_ENDUSER_ZIP_FILE

#Get the latest cartridges-endusermodels RPM file
if [ -e $TOP/$CART_ENDUSERMODELS_ZIP_FILE ] ; then
  rm $TOP/$CART_ENDUSERMODELS_ZIP_FILE
fi
curl -C - -O $CART_ENDUSERMODELS_ARTIFACTS_DIR/$CART_ENDUSERMODELS_ZIP_FILE

#Get the latest cartridges-enduser-defaults-allinone RPM file
if [ -e $TOP/$CART_ENDUSER_DEFAULTS_ALLINONE_ZIP_FILE ] ; then
  rm $TOP/$CART_ENDUSER_DEFAULTS_ALLINONE_ZIP_FILE
fi
curl -C - -O $CONFIGURATIONMANAGEMENTEU_ARTIFACTS_DIR/$CART_ENDUSER_DEFAULTS_ALLINONE_ZIP_FILE

#Get the latest cartridges-enduser-defaults-foglightonly RPM file
if [ -e $TOP/$CART_ENDUSER_DEFAULTS_FOGLIGHTONLY_ZIP_FILE ] ; then
  rm $TOP/$CART_ENDUSER_DEFAULTS_FOGLIGHTONLY_ZIP_FILE
fi
curl -C - -O $CONFIGURATIONMANAGEMENTEU_ARTIFACTS_DIR/$CART_ENDUSER_DEFAULTS_FOGLIGHTONLY_ZIP_FILE

#move the custom Quest RPMs to the customizations folder
tar -zxf $UPGRADE_DEVEL_ZIP_FILE
tar -zxf $APPLIANCEMON_ZIP_FILE
tar -zxf $ARCHIVER_ZIP_FILE
tar -zxf $OSCONFIG_ZIP_FILE
tar -zxf $CONSOLE_ZIP_FILE
tar -zxf $DELLOPENMANAGE_ZIP_FILE
tar -zxf $MYSQL_ZIP_FILE
tar -zxf $RELAYER_ZIP_FILE
tar -zxf $SNIFFER_ZIP_FILE
tar -zxf $LOCATIONDB_ZIP_FILE
tar -zxf $FMS_ZIP_FILE
tar -zxf $CART_ENDUSER_ZIP_FILE
tar -zxf $CART_ENDUSERMODELS_ZIP_FILE
tar -zxf $CART_ENDUSER_DEFAULTS_ALLINONE_ZIP_FILE
tar -zxf $CART_ENDUSER_DEFAULTS_FOGLIGHTONLY_ZIP_FILE

if [ -e $QUEST_RPMS_DIR ] ; then
  rm -fr $QUEST_RPMS_DIR
fi
mkdir -p $QUEST_RPMS_DIR/noarch
mkdir -p $QUEST_RPMS_DIR/x86_64

mv quest*.rpm $QUEST_RPMS_DIR/noarch
rm *.gz

#Move any patches to the Quest RPMs dir
cp $RPM_PATCHES_DIR/noarch/* $QUEST_RPMS_DIR/noarch
cp $RPM_PATCHES_DIR/x86_64/* $QUEST_RPMS_DIR/x86_64

#if [ $UID -ne $BUILDUSERID ] ; then
#  echo 'Need to be build user to run this script'
#  exit 1
#fi

pushd .

TOP=`pwd`

if [ ! -e base_dir ] ; then
  mkdir base_dir
fi

# clean up from past builds
rm ~/.makeSUSEdvdrc

if [ -e base_dir/CD_DIR ] ; then
  rm -fr base_dir/CD_DIR
fi

if [ -e DVD_DIR ] ; then
  rm -fr DVD_DIR
fi

#Extract entire SuSE install contents from SuSE iso (this will take a while)
clear
echo Extracting SuSE installation files from iso
echo This will take some time.
echo Enter the passphrase 'ecriticalinc' when prompted.

if [ -e $ISODIR/DVD_DIR ] ; then
  rm -fr $ISODIR/DVD_DIR
fi

makeSUSEdvd -i \
-a /home/binaries/3rdparty/rpms \
-a $QUEST_RPMS_DIR \
-d $ISODIR -t $BUILDDIR/base_dir/CD_DIR

cd $TOP
#copy the files needed for customization to the base CD_DIR
rm -fr $QUEST_RPMS_DIR
cp -fr customizations/* base_dir/CD_DIR/
CHANGELIST=`cat changelist`
VERSION=`cat version`

sed -i "s/CHANGELIST=/CHANGELIST=$CHANGELIST/" base_dir/CD_DIR/autoinst.xml
sed -i "s/CHANGELIST=/CHANGELIST=$CHANGELIST/" base_dir/CD_DIR/autoinst_legacy.xml
sed -i "s/CHANGELIST=/CHANGELIST=$CHANGELIST/" base_dir/CD_DIR/autoinst_archiver.xml
sed -i "s/CHANGELIST=/CHANGELIST=$CHANGELIST/" base_dir/CD_DIR/autoinst_foglight.xml
sed -i "s/CHANGELIST=/CHANGELIST=$CHANGELIST/" base_dir/CD_DIR/autoinst_sniffer.xml

sed -i "s/VERSION=/VERSION=$VERSION/" base_dir/CD_DIR/autoinst.xml
sed -i "s/VERSION=/VERSION=$VERSION/" base_dir/CD_DIR/autoinst_legacy.xml
sed -i "s/VERSION=/VERSION=$VERSION/" base_dir/CD_DIR/autoinst_archiver.xml
sed -i "s/VERSION=/VERSION=$VERSION/" base_dir/CD_DIR/autoinst_foglight.xml
sed -i "s/VERSION=/VERSION=$VERSION/" base_dir/CD_DIR/autoinst_sniffer.xml

chmod +x base_dir/CD_DIR/buildutil/*.sh

cd base_dir/CD_DIR

chmod +w ./buildutil/*.lst

./buildutil/rmextrarpms.sh

cd $TOP

makeSUSEdvd -C

echo "copying the artifacts..."
if [ -e artifacts ] ; then
  rm -fr artifacts
fi
mkdir artifacts

DATE=`date +%Y%m%d`
CHANGELIST=`cat ./changelist`
VERSION=`cat ./version`
BUILDID="$DATE"_"$CHANGELIST"
echo "$BUILDID" > artifacts/BUILDID

mv DVD_DIR/*.iso			artifacts/$ISOFNAME

cd artifacts
md5sum $ISOFNAME > ./$MD5FNAME

cd $TOP

chown -R jenkins.jenkins *

popd

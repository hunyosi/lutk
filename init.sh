#!/bin/sh

BOOST_VERSION=1.60.0
BOOST_NAME=boost_1_60_0

BASE_DIR=`pwd`
BOOST_BASE=$BASE_DIR/boost
BOOST_SRC_BASE=$BOOST_BASE/src
BOOST_BLT_BASE=$BOOST_BASE/bin
BOOST_SRC=$BOOST_SRC_BASE/$BOOST_NAME
BOOST_BLT=$BOOST_BLT_BASE/$BOOST_NAME
BOOST_BIN=$BOOST_BLT/bin

mkdir $BOOST_BASE
mkdir $BOOST_SRC_BASE
mkdir $BOOST_BLT_BASE
mkdir $BOOST_SRC
mkdir $BOOST_BLT
mkdir $BOOST_BIN

wget -O $BOOST_SRC_BASE/$BOOST_NAME.tar.bz2 http://sourceforge.net/projects/boost/files/boost/$BOOST_VERSION/$BOOST_NAME.tar.bz2/download

cd $BOOST_SRC_BASE
tar --bzip2 -xvf $BOOST_NAME.tar.bz2

cd $BOOST_SRC/tools/build
./bootstrap.sh
./b2 install --prefix=$BOOST_BUILT

PATH=$BOOST_BIN:$PATH
export PATH

cd $BASE_DIR
echo "#!/bin/sh" > start.sh
echo "PATH=$BOOST_BIN/bin:\$PATH" >> start.sh
echo "export PATH" >> start.sh
echo "BOOST_ROOT=$BOOST_SRC" >> start.sh
echo "export BOOST_ROOT" >> start.sh
echo $SHELL >>start.sh
chmod 744 start.sh


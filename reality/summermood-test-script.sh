#!/bin/sh

# sample script to run Reality Check to test a simple patch. 
# This script should work in linux or MacOS.  You can run it from a shell
# that is in the same directory the script is in, as in:
#     $ ./test-me.sh
# ... or, you can invoke it using a full path as in:
#     $ /somewhere/test-example/test-me.sh
#
# The executable "pd" is searched for in a few
# reasonable places but you can override this by setting environment variable
# "PD" as in:
#     $ PD=/usr/local/bin/pd ./test-me.sh
#
# you may also override these in the same way:
#
# REALITY -- the directory to find reality check in (../reality-check)
# DEBUG -- set this environment variable to a nonempty string to enable GUI
#

# search for PD executable

# change for your version
PD_VER="0.55-2"

if test x$PD == x; then
    if [ -f $HOME/Applications/Pd-$PD_VER.app/Contents/Resources/bin/pd ] ; then
        PD=$HOME/Applications/Pd-$PD_VER.app/Contents/Resources/bin/pd
    elif [ -f $HOME/Applications/Pd-$PD_VER.app/Contents/Resources/bin/pd ] ; then
        PD=/Applications/Pd-$PD_VER.app/Contents/Resources/bin/pd
    elif [ -f $HOME/pd/bin/pd ] ; then
        PD=$HOME/pd/bin/pd
    else
        PD=pd
    fi
fi

# try to figure out what directory this script is in

if [ "$0" != "${0#/}" ]
then DIR=`dirname $0`
else DIR=`pwd`
fi

if test x$SCRIPT == x; then
    SCRIPT=summermood-test-script.txt
fi

if test x$REALITY == x; then
    echo "cant find reality check"
    exit 1
fi

PATCH=$DIR/../summermood.pd

if test x$DEBUG == x; then
    CMD="$PD -batch -nosound -nrt -r 48000 -noprefs  \
        -send \"run-batch $DIR $DIR/$SCRIPT $PATCH\" \
        $REALITY/1.reality.pd"
else
    CMD="$PD -r 48000 -noprefs  \
        -send \"run-interactive $DIR $DIR/vector/$SCRIPT $PATCH\" \
        $REALITY/1.reality.pd"
fi

echo reality check test script.
echo Pd executable: $PD
echo reality check directory: $REALITY
echo running from directory: $DIR
echo run command: $CMD

echo '******************************'
echo


eval $CMD


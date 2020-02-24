#!/bin/bash

mkdir -p $STEAMCMDDIR
cd $STEAMCMDDIR

#Download steamcmd
wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf -

#Init steamcmd
$STEAMCMDDIR/steamcmd.sh +login anonymous +quit
ln -s $STEAMCMDDIR/linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so

#Update file
{ \
	echo '@ShutdownOnFailedCommand 1'; \
	echo '@NoPromptForPassword 1'; \
	echo 'login anonymous'; \
	echo 'force_install_dir $STEAMAPPDIR'; \
	echo 'app_update $STEAMAPPID'; \
	echo 'quit'; \
} > $STEAMCMDDIR/update.txt
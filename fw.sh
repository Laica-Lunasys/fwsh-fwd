#!/bin/bash

CMDNAME=`basename $0`

while getopts p:r:l OPT
do
  case $OPT in
    "p" ) FLG_ADD="TRUE" ; VALUE_ADD="$OPTARG" ;;
    "r" ) FLG_REM="TRUE" ; VALUE_REM="$OPTARG" ;;
    "l" ) FLG_LIST="TRUE" ;;
    * ) echo "Usage: $CMDNAME [-p port/tcp(/udp)] [-r port/tcp(/udp)] [-l]" 1>&2
          exit 1 ;;
  esac
done

if [ "$FLG_ADD" = "TRUE" ]; then
  echo ポート許可を設定しています...
  sudo firewall-cmd --add-port="${VALUE_ADD}"

  echo 永続的なポート許可を設定しています...
  sudo firewall-cmd --permanent --add-port="${VALUE_ADD}"

  echo Reloading...
  sudo firewall-cmd --reload

  echo 完了しました!!!
fi

if [ "$FLG_REM" = "TRUE" ]; then
  echo ポート許可を解除しようとしています...
  sudo firewall-cmd --remove-port="${VALUE_REM}"

  echo 永続的なポート許可を解除しようとしています...
  sudo firewall-cmd --permanent --remove-port="${VALUE_REM}"

  echo Reloading...
  sudo firewall-cmd --reload
  echo 完了しました!!!
fi

if [ "$FLG_LIST" = "TRUE" ]; then
  echo 許可済みのポートを取得します...
  sudo firewall-cmd --list-ports
fi

exit 0

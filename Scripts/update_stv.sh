#!/usr/bin/env bash

set -euo pipefail

echo Starting update_stv.sh
update_stv_config_path="/media/fat/Scripts/.config/update_stv"

if ! [ -e $update_stv_config_path ]; then
  mkdir $update_stv_config_path
  echo 0 > $update_stv_config_path/mra_version
fi

# If you want to overwrite the defaults for the $stv_rbf_path and $stv_rbf_type variables
# set them in /media/fat/Scripts/update_stv.ini
if [ -e /media/fat/Scripts/update_stv.ini ]; then
  source /media/fat/Scripts/update_stv.ini
fi


print_banner() {
echo "
                          ___________  _    __
                         / ___/_  __/ | |  / /
                         \__ \ / /____| | / /
                        ___/ // /_____/ |/ /
                       /____//_/      |___/

                 SEGA TITAN VIDEO GAME SYSTEM UPDATER

         !!! NOTE: This script is no longer needed and does nothing !!!
"
}

print_banner

echo update_stv.sh finished

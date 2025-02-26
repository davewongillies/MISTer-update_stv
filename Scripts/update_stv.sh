#!/usr/bin/env bash

set -euo pipefail

echo Starting update_stv.sh
update_stv_config_path="/media/fat/Scripts/.config/update_stv"

if ! [ -e $update_stv_config_path ]; then
  mkdir $update_stv_config_path
  echo 0 > $update_stv_config_path/mra_version
fi

# The path where to look for your ST-V rbf core file
stv_rbf_path="/media/fat/_Unstable"

# The type of ST-V rbf file, eg: "unstable", "DualSDRAM_unstable"
stv_rbf_type="unstable"

manage_rbf="true"

# If you want to overwrite the defaults for the $stv_rbf_path and $stv_rbf_type variables
# set them in /media/fat/Scripts/update_stv.ini
if [ -e /media/fat/Scripts/update_stv.ini ]; then
  source /media/fat/Scripts/update_stv.ini
fi

manage_rbfs() {
  if [ "${manage_rbf}" != "true" ]; then
    return
  fi

  stv_rbf=$(find ${stv_rbf_path} -name "ST-V_${stv_rbf_type}*.rbf")

  if [ "${stv_rbf}" = "" ]; then
    echo ${stv_rbf_path}/ST-V_${stv_rbf_type}*.rbf not found, exiting
    exit 0
  fi

  if ! [ -e $update_stv_config_path/mra_version ]; then
      echo 0 > $update_stv_config_path/mra_version
  fi

  stv_rbf_symlink="$(readlink /media/fat/_Arcade/cores/ST-V.rbf; true)"

  if [ "${stv_rbf_symlink}" != "${stv_rbf}" ]; then
    echo Linking new version $stv_rbf to /media/fat/_Arcade/cores/ST-V.rbf...

    ln --symbolic --force --verbose ${stv_rbf} /media/fat/_Arcade/cores/ST-V.rbf
  else
      echo /media/fat/_Arcade/cores/ST-V.rbf is up to date
  fi
}

manage_mras() {
  stv_mra_json=/tmp/stv-mra.json

  echo Checking STV-MRA for latest version
  curl -k -sS https://api.github.com/repos/zakk4223/STV-MRA/releases/latest > $stv_mra_json

  mra_latest_version=$(jq -r .name < $stv_mra_json)
  mra_current_version=$(cat /media/fat/Scripts/.config/update_stv/mra_version)

  if [ "$mra_latest_version" != "$mra_current_version" ]; then
    echo New version $mra_latest_version found, downloading release asset...
    curl -L -k -sS $(jq -r .assets[].browser_download_url < $stv_mra_json) > /tmp/stv-mra.zip
    unzip -o /tmp/stv-mra.zip -d /media/fat/_Arcade/
    echo $mra_latest_version > $update_stv_config_path/mra_version
    rm -f /tmp/stv-mra.zip
    rm -f $stv_mra_json
    echo STV-MRA version ${mra_latest_version} installed
  else
    echo STV-MRA is up to date at version $mra_current_version
  fi
}

migrate_dbjson() {
  if grep -qi "davewongillies/MISTer-update_stv/refs/heads/master/db\.json" /media/fat/downloader.ini; then
    sed -i -e \
      's!davewongillies/MISTer-update_stv/refs/heads/master/db\.json!davewongillies/MiSTer-update_stv/db/db.json.zip!i' \
      /media/fat/downloader.ini
    echo Updated downloader.ini configuration to new location
  fi
}

migrate_dbjson
manage_rbfs
manage_mras

echo update_stv.sh finished

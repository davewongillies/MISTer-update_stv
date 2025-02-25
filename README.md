# update-stv.sh

A simple update script for keeping the latest version of the ST-V core setup and the latest [ST-V MRAs](https://github.com/zakk4223/STV-MRA) for use with the ST-V core on the MiSTer.

## Prerequistes

* [`update_all.sh`](https://github.com/theypsilon/Update_All_MiSTer)
* unstable nightlies is setup in `/media/fat/downloader.ini`

```ini
[unstable_nightlies_folder]
db_url = https://raw.githubusercontent.com/MiSTer-unstable-nightlies/Unstable_Folder_MiSTer/refs/heads/main/db_unstable_nightlies_folder.json
```

## Setup

1. Add the following to `/media/fat/downloader.ini`

```init
[update_stv]
db_url = https://raw.githubusercontent.com/davewongillies/MISTer-update_stv/refs/heads/master/db.json
```

2. Run `update_stv` from the Scripts menu on your MiSTer

## Configuration

Some of the settings of this script can be changed by creating the file `/media/fat/Scripts/update_stv.ini`

* `stv_rbf_type`: the type of ST-V rbf file, eg: `"unstable"`, `"DualSDRAM_unstable"`
* `stv_rbf_path`: the path where to look for your ST-V rbf core file, Default: `/media/fat/_Unstable`

### Example config

```ini
stv_rbf_type="DualSDRAM_unstable"
```

## Keeping things up to date

Whenever the ST-V unstable nightly cores are updated or there's a new version of the ST-V MRAs, run `update_stv` from the Scripts menu

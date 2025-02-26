# update-stv.sh

A simple update script for keeping the latest version of the ST-V core setup and the latest [ST-V MRAs](https://github.com/zakk4223/STV-MRA) for use with the ST-V core on the MiSTer.

## Prerequistes

* unstable nightlies setup in `/media/fat/downloader.ini` if you want to
  automatically have unstable cores downloaded for you (recommended):

```ini
[unstable_nightlies_folder]
db_url = https://raw.githubusercontent.com/MiSTer-unstable-nightlies/Unstable_Folder_MiSTer/refs/heads/main/db_unstable_nightlies_folder.json
```

## Setup

1. Add the following to `/media/fat/downloader.ini`

```init
[update_stv]
db_url = https://raw.githubusercontent.com/davewongillies/MiSTer-update_stv/db/db.json.zip
```

2. Run `update_stv` from the Scripts menu on your MiSTer

## Configuration

Some of the settings of this script can be changed by creating the file `/media/fat/Scripts/update_stv.ini`

* `stv_rbf_type`: the type of ST-V rbf file, eg: `"unstable"`, `"DualSDRAM_unstable"`
* `stv_rbf_path`: the path where to look for your ST-V rbf core file, Default: `/media/fat/_Unstable`
* `manage_rbf`: whether `update_stv` will manage the symlinking of the core rbf file
   or not. For people who want to manually copy the core rbf file and just have the
   MRAs managed by this script.

### Example config

```ini
stv_rbf_type="DualSDRAM_unstable"
```

An example ini configuration file can also be found in `/media/fat/Scripts/update_stv.ini.example`.
This can be copied to `/media/fat/Scripts/update_stv.ini`.

**NOTE** If copying this file from Windows be sure that in your editor of choice
that you set Unix line (LF) endings for `update_stv.ini`.

## Keeping things up to date

Whenever the ST-V unstable nightly cores are updated or there's a new version of the ST-V MRAs, run `update_stv` from the Scripts menu

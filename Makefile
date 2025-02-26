DB_JSON := db.json

all: Scripts/update_stv.ini.example Scripts/update_stv.sh
	@echo "Updating ${DB_JSON}"
	@yq -i '.timestamp = $(shell date +%s)' ${DB_JSON}

.PHONY: Scripts/update_stv.sh Scripts/update_stv.ini.example
Scripts/update_stv.sh Scripts/update_stv.ini.example:
	@yq -i '.files."$@".hash = "$(shell md5sum $@|cut -f1 -d" ")"' ${DB_JSON}
	@yq -i '.files."$@".size = $(shell du -sb $@|cut -f1)' ${DB_JSON}

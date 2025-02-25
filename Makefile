all:
	@echo "Updating db.json"
	@yq -i '.files."Scripts/update_stv.sh".hash = "$(shell md5sum Scripts/update_stv.sh|cut -f1 -d" ")"' db.json
	@yq -i '.files."Scripts/update_stv.sh".size = $(shell du -sb Scripts/update_stv.sh|cut -f1)' db.json
	@yq -i '.timestamp = $(shell date +%s)' db.json

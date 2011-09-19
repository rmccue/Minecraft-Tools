# i.e. all of them are phony. probably don't really need this,
# but better safe than sorry
.PHONY: borderguard essentials heroicdeath iconomy logblock \
	magiccarpet nocheat permissions propertime spyer wolfpound \
	worldedit worldguard survival pvp backup bukkit

# Change to bt22 for stable instead.
EssURL = http://ci.earth2me.net/repository/download/bt2/.lastSuccessful
getPlugin = @cd plugins; wget -nv -N
ToolsDir = ~/minecraft/tools
GetDevBukkit = @cd plugins; wget -nv `python $(ToolsDir)/dev.bukkit.py $(1)`
Backup = @cd plugins; if [ -f $(1) ]; then mv -f $(1) $(1).bak; fi
BUILDID := $(shell python $(ToolsDir)/bukkit-build.py)

borderguard:
	$(getPlugin) http://minerealm.com/plugins/borderguard/BorderGuard.jar

essentials:
	$(getPlugin) $(EssURL)/Essentials.jar?guest=1 --content-disposition
	$(getPlugin) $(EssURL)/EssentialsProtect.jar?guest=1 --content-disposition
	$(getPlugin) $(EssURL)/EssentialsChat.jar?guest=1 --content-disposition
	$(getPlugin) $(EssURL)/EssentialsSpawn.jar?guest=1 --content-disposition
	$(getPlugin) $(EssURL)/EssentialsGeoIP.jar?guest=1 --content-disposition

logblock:
	@cd plugins; wget -nv `python $(ToolsDir)/logblock.py` -O logblock.zip
	$(call Backup,LogBlock.jar)
	$(call Backup,LogBlockQuestioner.jar)
	@cd plugins; unzip -n logblock.zip
	@cd plugins; rm INSTALL.txt logblock.zip

lockette:
	$(call GetDevBukkit,lockette) -O lockette.zip
	$(call Backup,Lockette.jar)
	@cd plugins; unzip -n lockette.zip
	@cd plugins; rm lockette.zip

modtrs:
	@cd plugins; wget -nv https://github.com/downloads/yetanotherx/ModTRS/ModTRS-bin.zip -O trs.zip
	$(call Backup,ModTRS.jar)
	@cd plugins; unzip -n trs.zip
	@cd plugins; rm README trs.zip

permissions:
	$(getPlugin) http://www.theyeticave.net/downloads/permissions/3.1.6/Permissions.jar

permissionsex:
	$(call GetDevBukkit,permissionsex) -O pex.zip
	$(call Backup,PermissionsEx.jar)
	$(call Backup,Permissions.jar)
	$(call Backup,Modifyworld.jar)
	$(call Backup,ChatManager.jar)
	@cd plugins; unzip -n pex.zip
	@cd plugins; rm pex.zip

simplejail:
	$(getPlugin) https://github.com/downloads/imjake9/SimpleJail/SimpleJail.jar

spout:
	$(getPlugin) http://ci.getspout.org/job/Spout/Recommended/artifact/target/Spout.jar

spoutdev:
	$(getPlugin) http://ci.getspout.org/job/Spout/lastSuccessfulBuild/artifact/target/spout-dev-SNAPSHOT.jar  --content-disposition
	@mv plugins/spout-dev-SNAPSHOT.jar plugins/Spout.jar

vanish:
	$(call GetDevBukkit,vanish)

worldedit:
	$(call GetDevBukkit,worldedit)

worldguard:
	@echo Fuck WorldGuard.

survival: borderguard essentials lockette logblock permissions permissionsex simplejail spout worldedit worldguard

pvp: borderguard permissions spoutdev worldedit

backup-plugins:
	@cp -r plugins plugins-bak

bukkit:
ifneq ($(shell readlink craftbukkit.jar),craftbukkit.$(BUILDID).jar)
	@wget -nv http://ci.bukkit.org/job/dev-CraftBukkit/lastSuccessfulBuild/artifact/target/craftbukkit-0.0.1-SNAPSHOT.jar -O craftbukkit.$(BUILDID).jar
	@ln -s -f  craftbukkit.$(BUILDID).jar craftbukkit.jar
endif

craftbukkit.jar: bukkit

clean:
	cd plugins; rm *.bak

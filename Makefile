.PHONY: all $(MAKECMDGOALS)

all: compile install

# set up the local environment for builds
setup:
	python3 -m venv .venv
	. .venv/bin/activate; pip install -r requirements.txt
	bundle config set --local path './.gem'
	bundle install
	@echo 'To activate venv call "source .venv/bin/activate"'

# compile eevee data files, maps, and events
compile:
	bundle exec ruby ruby_code/compile_tiled.rb 
	bundle exec ruby tools/eevee/eevee.rb import
# 	battle animation importer is busted, so we just copy the rxdata
	cp src/data/Data/* src/data/Data/.

# copy pictures,audio,etc to essentials folder
install:
	./scripts/install_assets.sh

# convert rxdata files to source files
decompile:
	./scripts/convert_autotiles.sh
	bundle exec ruby tools/eevee/eevee.rb export
# FIXME Shouldn't have to do this, but the battle animation import/export is broken
	cp --update --parents "src/essentials/Data/move2anim.dat" "src/data/Data/."
	cp --update --parents "src/essentials/Data/PkmnAnimations.rxdata" "src/data/Data/."
	bundle exec ruby ruby_code/extract_events.rb
	bundle exec ruby ruby_code/generate_tsx.rb
	bundle exec ruby ruby_code/generate_tmx.rb

# backup non-github essentials assets and decompile to source if possible
backup: decompile
	./scripts/extract_assets.sh

# clean out the essentials Data folder
clean:
	./scripts/clean_data.sh

# remove rxdata and assets
distclean:
	./scripts/clean_data.sh
	./scripts/uninstall_assets.sh

# delete sources (useful for testing decompiles)
src_clean:
	rm -rf src/events
	rm -rf src/data
	rm -rf src/tiled/maps
	rm -rf src/tiled/tilesets